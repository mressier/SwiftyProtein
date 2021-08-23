import Foundation

extension PDBLigandConverter {

  private static var CONNECT_INPUT = "CONECT"
  private static var CONNECT_REGEX = "CONECT(.{5})(.{5})(.{5})?(.{5})?(.{5})?"

  //----------------------------------------------------------------------------
  // MARK: - Format
  //----------------------------------------------------------------------------

  static func isConnectInput(string: String) -> Bool {
    return string.starts(with: CONNECT_INPUT)
  }

  //----------------------------------------------------------------------------
  // MARK: - Converter
  //----------------------------------------------------------------------------

  static func connections(from line: String) throws -> PDBConnection {
    guard let connectionsPart = getConnectionsParts(from: line) else {
      throw ContentError.invalidConnectLineFormat(line)
    }

    let connections = connectionsPart.compactMap() { Int($0) }

    guard connections.count == connectionsPart.count else {
      throw ContentError.invalidConnectIndex(line)
    }

    return try PDBConnection(connections)
  }

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  private static func getConnectionsParts(from line: String) -> [String]? {
    guard var connections =
      try? line.substringMatches(regex: CONNECT_REGEX).first else { return nil }

    connections.remove(at: 0) // remove global match

    return connections.map() { $0.trimmed() }
  }
}
