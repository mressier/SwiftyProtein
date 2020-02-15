import Foundation
import SceneKit

struct AtomNode {
  let atom: Atom
  let node: SCNNode
}

typealias AtomPair = PathBounds<AtomNode>

extension Array where Element == AtomNode {

  //----------------------------------------------------------------------------
  // MARK: - Atom Pairs
  //----------------------------------------------------------------------------

  /// Get all pairs of atom from links between atoms.
  func extractAtomPairs() -> [AtomPair] {
    var atomsPairs = [AtomPair]()

    for (index, atom) in self.enumerated() {
      let linkedAtoms = getLinkedAtoms(to: atom.atom)
      let pairs = linkedAtoms.pair(to: atom)
      atomsPairs.append(contentsOf: pairs)
    }

    return atomsPairs
  }

  /// Create an array of paired atom. Return every atom of the array paired with the given atom.
  func pair(to atom: AtomNode) -> [AtomPair] {
    return map() { AtomPair(start: atom, end: $0) }
  }

  //----------------------------------------------------------------------------
  // MARK: - Linked Atoms
  //----------------------------------------------------------------------------

  func getLinkedAtoms(to atom: Atom) -> [AtomNode] {
    var linkedAtoms = [AtomNode]()

    let linkedAtomsIndexes =
      atom.linkedAtoms.filter() { $0 > atom.index }

    for linkedAtomIndex in linkedAtomsIndexes {
      guard let linkedAtom =
        self.getAtom(with: linkedAtomIndex) else { continue }
      linkedAtoms.append(linkedAtom)
    }

    return linkedAtoms
  }

  //----------------------------------------------------------------------------
  // MARK: - Atom
  //----------------------------------------------------------------------------

  func getAtom(with index: Int) -> AtomNode? {
    return first(where: { $0.atom.index == index })
  }

}
