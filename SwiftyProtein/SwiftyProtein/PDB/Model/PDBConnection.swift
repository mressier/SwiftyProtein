import Foundation

/*******************************************************************************
 * PDBConnection
 *
 * Represent a connection between an atom with a given index and other atoms index
 *
 ******************************************************************************/
struct PDBConnection: Equatable {
  let source: Int
  let linkedTo: [Int]

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(_ linksList: [Int]) throws {
    guard linksList.count > 1 else {
      throw PDBLigandConverter.ContentError.invalidConnectIndex("\(linksList)")
    }
    
    source = linksList[0]
    linkedTo = Array(linksList[1 ..< linksList.count])
  }

  init(source: Int, linkedTo: [Int]) {
    self.source = source
    self.linkedTo = linkedTo
  }

  //----------------------------------------------------------------------------
  // MARK: - Equatable
  //----------------------------------------------------------------------------
  static func ==(_ lhs: PDBConnection, rhs: PDBConnection) -> Bool {
    return lhs.source == rhs.source && lhs.linkedTo == rhs.linkedTo
  }
}
