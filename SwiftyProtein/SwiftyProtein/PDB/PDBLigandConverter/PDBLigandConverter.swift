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

  fileprivate mutating func applyConnections(_ connections: [PDBConnection]) {
    for (index, atom) in self.enumerated() {
      let connectionsForAtom = connections.filter() { $0.source == atom.index }
      let linkedsAtomIndexes = connectionsForAtom.map() { $0.linkedTo }.joined()

      self[index].linkedAtomIndex.append(contentsOf: linkedsAtomIndexes)
    }
  }

}
