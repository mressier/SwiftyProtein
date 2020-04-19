import Foundation

struct PDBLigandConverter {

  enum ContentError {
    case invalidAtomFormat
    case invalidConnectionFormat
  }

  static func atoms(from lines: [String]) throws -> [PDBAtom] {
    var state: ReadState = .atomList
    var atoms = [PDBAtom]()
    var atomsConnections = [[Int]]()

    for line in lines {

      while state != .end, state.checkInputType(line) == false {
        state = state.next
      }

      guard state != .end else {
        print("probably a syntax error on line \(line)")
        break
      }

      if state == .atomList {
        if let atom = try PDBLigandConverter.atom(from: line) {
          atoms.append(atom)
        }
      }

      if state == .connectionList {
        let connections = try PDBLigandConverter.connections(from: line)
        atomsConnections.append(connections)
      }

    }
    return []
  }
}
