import Foundation

/*******************************************************************************
 * PDBLigand
 *
 * Represent ligand informations given by a PDB File
 *
 ******************************************************************************/
struct PDBLigand: Equatable {
  let name: String
  let coordinatesModel: PDBCoordinateModel
  let atoms: [PDBAtom]

  //----------------------------------------------------------------------------
  // MARK: - Equatable
  //----------------------------------------------------------------------------

  static func ==(_ lhs: PDBLigand, _ rhs: PDBLigand) -> Bool {
    return lhs.name == rhs.name
      && lhs.atoms == rhs.atoms
      && lhs.coordinatesModel == rhs.coordinatesModel
  }
}
