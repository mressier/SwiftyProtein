import Foundation
import SceneKit

extension Array where Element == SCNAtomNode {

  //----------------------------------------------------------------------------
  // MARK: - Convert array to dictionary
  //----------------------------------------------------------------------------

  var dictionaryByNode: [SCNNode: SCNAtomNode] {
    return self.reduce(into: [SCNNode: SCNAtomNode]()) { result, atom in
      result[atom] = atom
    }
  }

  var dictionaryByIndex: [Int: SCNAtomNode] {
    return self.reduce(into: [Int: SCNAtomNode]()) { result, atom in
      result[atom.atom.index] = atom
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Get Atom Pairs
  //----------------------------------------------------------------------------

  /// Get all pairs of atom from links between atoms.
  /// Complexity in time is
  func extractAtomPairs() -> [AtomPair] {
    let atomsByIndex =
      AtomNodeDictionaryReader(atomByIndex: self.dictionaryByIndex)

    let atomsPairs = self.reduce([]) { result, node -> [AtomPair] in
      guard let atom = node.atom else { return result }

      let higherLinkedAtomIndexes = atom.isHydrogen ?
        atom.linkedAtomIndexes : atom.higherLinkedAtomsIndexes

      let linkedAtoms = atomsByIndex.getAtoms(at: higherLinkedAtomIndexes)

      let pairs = node.getAtomPairs(to: linkedAtoms)
      return result + pairs
    }

    return atomsPairs
  }
}
