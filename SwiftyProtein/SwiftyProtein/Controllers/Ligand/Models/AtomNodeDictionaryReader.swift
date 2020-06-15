import Foundation

/*******************************************************************************
 * AtomNodeDictionary
 *
 * Atom Nodes ordered by atom index
 *
 ******************************************************************************/
struct AtomNodeDictionaryReader {

  let atomByIndex: [Int: SCNAtomNode]

  //----------------------------------------------------------------------------
  // MARK: - Read on dictionary
  //----------------------------------------------------------------------------

  func getAtoms(at indexes: [Int]) -> [SCNAtomNode] {
    return indexes.reduce([]) { result, index in
      guard let atom = atomByIndex[index] else { return result }
      return result + [atom]
    }
  }
}
