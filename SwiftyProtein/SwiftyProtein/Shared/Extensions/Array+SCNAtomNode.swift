import Foundation
import SceneKit

extension Array where Element == SCNAtomNode {

  /// Area covered  by the atom
  var areaCovered: Area3D {
    let firstPosition = self.first?.atom?.position
    let area = Area3D(min: firstPosition ?? .zero, max: firstPosition ?? .zero)

    self.forEach() { node in
      area.update(min: node.atom.position)
      area.update(max: node.atom.position)
    }

    return area
  }

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
