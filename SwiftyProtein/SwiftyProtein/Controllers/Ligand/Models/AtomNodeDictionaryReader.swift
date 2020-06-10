import Foundation

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
