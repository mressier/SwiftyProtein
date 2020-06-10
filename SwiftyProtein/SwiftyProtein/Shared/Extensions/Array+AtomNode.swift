import Foundation
import SceneKit

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
    let atomByIndex = self.dictionaryByIndex // O(nbOfAtoms)

    let atomsPairs = self.reduce([]) { result, atom -> [AtomPair] in
      let isHydrogen = atom.atom.symbol == AtomsList.hydrogen.symbol

      let higherLinkedAtomIndexes = isHydrogen ?
        atom.linkedAtoms : atom.linkedAtoms.filter() { $0 > atom.index } // O(nbOfLinks)

      let linkedAtoms =
        AtomNodeDictionaryReader.getAtoms(on: atomByIndex,
                                          at: higherLinkedAtomIndexes) // O(nbOfLinks)
      let pairs = linkedAtoms.pair(to: atom) // O(nbOfLinks)
      return result + pairs
    }

    return atomsPairs
  }

  /// Create an array of paired atom. Return every atom of the array paired with the given atom.
  func pair(to atom: AtomNode) -> [AtomPair] {
    return map() { AtomPair(start: atom, end: $0) }
  }

  var areaCovered: Area3D {
    let firstPosition = self.first?.atom.position ?? PDBAtomPosition.zero
    let area = Area3D(min: firstPosition, max: firstPosition)

    self.forEach() { node in
      area.update(min: node.atom.position)
      area.update(max: node.atom.position)
    }

    return area
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
