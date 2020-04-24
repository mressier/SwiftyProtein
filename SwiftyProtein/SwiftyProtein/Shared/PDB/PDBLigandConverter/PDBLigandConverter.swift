import Foundation

struct PDBLigandConverter {

  //----------------------------------------------------------------------------
  // MARK: - Create atoms from lines instructions
  //----------------------------------------------------------------------------

  static func ligand(name: String,
                     from fileContent: String) throws -> PDBLigand {
    let lines = fileContent.split(separator: "\n").map() { String($0) }
    return try ligand(name: name, from: lines)
  }

  static func ligand(name: String,
                     from lines: [String]) throws -> PDBLigand {
    var state: ReadState = .atomList
    var atoms = [PDBAtom]()
    var atomsConnections = [PDBConnection]()

    for line in lines {

      while state != .end, state.checkInputType(line) == false {
        state = state.next
      }

      if state == .end {
        guard state.checkInputType(line) else {
          throw ContentError.invalidFormat("Line unconvertible: \(line)")
        }
        break
      }

      if state == .atomList, isAtomInput(string: line) {
        let atom = try PDBLigandConverter.atom(from: line)
        atoms.append(atom)
      }

      if state == .connectionList {
        let connections = try PDBLigandConverter.connections(from: line)
        atomsConnections.append(connections)
      }
    }

    atoms.applyConnections(atomsConnections)

    return PDBLigand(name: name, atoms: atoms)
  }
}

//------------------------------------------------------------------------------
// MARK: - Array
//------------------------------------------------------------------------------

extension Array where Element == PDBAtom {

  /// Apply given connections to atoms.
  /// Expect connections to be incremental, starting with the lowest atom index source value.
  fileprivate mutating func applyConnections(_ connections: [PDBConnection]) {
    let mergedConnections = connections.mergeSameSourceIndex()
    var connectionIndex = mergedConnections.startIndex

    for (index, atom) in self.enumerated() {
      connectionIndex = mergedConnections.nextIndex(after: connectionIndex, where: {
        $0.source >= atom.index
      }) ?? mergedConnections.endIndex

      guard connectionIndex < mergedConnections.count else { return }

      guard mergedConnections[connectionIndex].source == atom.index else { continue }

      let linkedAtomIndexes = mergedConnections[connectionIndex].linkedTo
      self[index].linkedAtomIndex.append(contentsOf: linkedAtomIndexes)
    }
  }

}

extension Array where Element == PDBConnection {

  /// Merge connections with the same source index
  func mergeSameSourceIndex() -> [PDBConnection] {
    var connections = [PDBConnection]()
    var lastIndex: Int? = nil

    for connection in self {
      if let index = lastIndex,
        connections[index].source == connection.source {
        connections[index].linkedTo.append(contentsOf: connection.linkedTo)
      } else {
        connections.append(connection)
        lastIndex = (lastIndex ?? -1) + 1
      }
    }

    return connections
  }
}
