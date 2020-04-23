import Foundation

extension PDBLigandConverter {

  enum ContentError: Error {
    case invalidAtomLineFormat(_ description: String)
    case invalidAtomValue(_ value: String)
    case invalidConnectLineFormat(_ description: String)
    case invalidConnectIndex(_ string: String)
    case invalidFormat(_ description: String)
  }

}
