import Foundation
import SceneKit

/*******************************************************************************
 * AtomNode
 *
 * Atom representation on a view with a node
 *
 ******************************************************************************/
struct AtomNode {
  let atom: PDBAtomLight
  let node: SCNNode

  var isSelected: Bool = false

  //----------------------------------------------------------------------------
  // MARK: - Computed
  //----------------------------------------------------------------------------

  var index: Int { return atom.index }

  var linkedAtoms: [Int] { return atom.linkedAtoms }

  static func ==(lhs: AtomNode, rhs: AtomNode) -> Bool {
    return lhs.node == rhs.node && lhs.atom == rhs.atom
  }
}

/*******************************************************************************
 * AtomPair
 *
 * Represent two linked atoms
 *
 ******************************************************************************/
typealias AtomPair = PathBounds<AtomNode>

//----------------------------------------------------------------------------
// MARK: - AtomNode Array actions
//----------------------------------------------------------------------------

extension Array where Element == AtomNode {

  //----------------------------------------------------------------------------
  // MARK: - Atom Pairs
  //----------------------------------------------------------------------------

  /// Get all pairs of atom from links between atoms.
  /// Complexity in time is
  func extractAtomPairs() -> [AtomPair] {
    var atomsPairs = [AtomPair]()
    let atomByIndex = self.dictionaryByIndex // O(nbOfAtoms)

    for atom in self { // O(nbOfAtoms)
      let isHydrogen = atom.atom.symbol == AtomsList.hydrogen.symbol

      let higherLinkedAtomIndexes = isHydrogen ?
        atom.linkedAtoms : atom.linkedAtoms.filter() { $0 > atom.index }

      let linkedAtoms =
        AtomNodeDictionaryReader.getAtoms(on: atomByIndex,
                                          at: higherLinkedAtomIndexes) // O(nbOfLinks)
      let pairs = linkedAtoms.pair(to: atom) // O(nbOfLinks)
      atomsPairs.append(contentsOf: pairs)
    }

    return atomsPairs
  }

  /// Create an array of paired atom. Return every atom of the array paired with the given atom.
  func pair(to atom: AtomNode) -> [AtomPair] {
    return map() { AtomPair(start: atom, end: $0) }
  }

  //----------------------------------------------------------------------------
  // MARK: - AtomNode to dictionary
  //----------------------------------------------------------------------------

  var dictionaryByNode: [SCNNode: AtomNode] {
    var dict = [SCNNode: AtomNode]()
    for atomNode in self {
      dict[atomNode.node] = atomNode
    }
    return dict
  }

  var dictionaryByIndex: [Int: AtomNode] {
    var dict = [Int: AtomNode]()
    for atomNode in self {
      dict[atomNode.index] = atomNode
    }
    return dict
  }
}

/*******************************************************************************
 * AtomNodeDictionary
 *
 * Atom Nodes ordered by atom index
 *
 ******************************************************************************/
struct AtomNodeDictionaryReader {

  //----------------------------------------------------------------------------
  // MARK: - Read on dictionary
  //----------------------------------------------------------------------------

  static func getAtoms(on atomByIndex: [Int: AtomNode],
                       at indexes: [Int]) -> [AtomNode] {
    return indexes.reduce([]) { result, index in
      guard let atom = atomByIndex[index] else { return result }
      return result + [atom]
    }
  }
}
