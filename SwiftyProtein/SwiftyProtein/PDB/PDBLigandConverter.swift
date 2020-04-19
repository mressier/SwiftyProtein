import Foundation

struct PDBLigandConverter {

  //----------------------------------------------------------------------------
  // MARK: - Converter Errors
  //----------------------------------------------------------------------------

  enum ContentError: Error {
    case invalidAtomLineFormat(_ description: String)
    case invalidAtomValue(_ value: String)
    case invalidConectLineFormat(_ description: String)
    case invalidConectIndex(_ string: String)
    case invalidFormat(_ description: String)
  }

  //----------------------------------------------------------------------------
  // MARK: - Create atoms from lines instructions
  //----------------------------------------------------------------------------

  static func atoms(from lines: [String]) throws -> [PDBAtom] {
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

    return atoms
  }
}

extension Array where Element == PDBAtom {

  mutating func applyConnections(_ connections: [PDBConnection]) {
    for (index, atom) in self.enumerated() {
      let connectionsForAtom = connections.filter() { $0.source == atom.index }
      let linkedsAtomIndexes = connectionsForAtom.map() { $0.linkedTo }.joined()

      self[index].linkedAtomIndex.append(contentsOf: linkedsAtomIndexes)
    }
  }

}
