import Foundation

extension PDBLigandConverter {

  enum ContentError: Error {
    case invalidAtomLineFormat(_ description: String)
    case invalidAtomValue(_ value: String)
    case invalidConectLineFormat(_ description: String)
    case invalidConectIndex(_ string: String)
    case invalidFormat(_ description: String)
  }

}
