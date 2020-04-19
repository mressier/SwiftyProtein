import Foundation

extension PDBLigandConverter {

  private static var ATOM_INPUT = "ATOM  "
  private static var HETATM_INPUT = "HETATM "

  //----------------------------------------------------------------------------
  // MARK: - Format
  //----------------------------------------------------------------------------

  static func isAtomInput(string: String) -> Bool {
    return string.starts(with: ATOM_INPUT)
  }

  static func isHetatmInput(string: String) -> Bool {
    return string.starts(with: HETATM_INPUT)
  }

  //----------------------------------------------------------------------------
  // MARK: - Converter
  //----------------------------------------------------------------------------

  static func atom(from line: String) throws -> PDBAtom? {
    return nil
  }
}
