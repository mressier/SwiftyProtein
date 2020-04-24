import Foundation

extension PDBLigandConverter {

  static let END_INPUT = "END"

  static func isEndInput(string: String) -> Bool {
    return string.starts(with: END_INPUT)
  }
}
