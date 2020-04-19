import Foundation

struct PDBLigand: Equatable {
  let atoms: [PDBAtom]

  static func ==(_ lhs: PDBLigand, _ rhs: PDBLigand) -> Bool {
    return lhs.atoms == rhs.atoms
  }
}
