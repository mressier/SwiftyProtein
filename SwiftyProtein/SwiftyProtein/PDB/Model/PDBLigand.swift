import Foundation

/*******************************************************************************
 * PDBLigand
 *
 * Represent ligand informations given by a PDB File
 *
 ******************************************************************************/
struct PDBLigand: Equatable {
  let name: String
  let atoms: [PDBAtom]

  static func ==(_ lhs: PDBLigand, _ rhs: PDBLigand) -> Bool {
    return lhs.atoms == rhs.atoms
  }
}
