import Foundation

extension PDBLigandConverter {

  private static var CONNECT_INPUT = "CONECT"

  //----------------------------------------------------------------------------
  // MARK: - Format
  //----------------------------------------------------------------------------

  static func isConnectionInput(string: String) -> Bool {
    return string.starts(with: CONNECT_INPUT)
  }

  //----------------------------------------------------------------------------
  // MARK: - Converter
  //----------------------------------------------------------------------------

  static func connections(from line: String) throws -> [Int] {
    return []
  }
}
