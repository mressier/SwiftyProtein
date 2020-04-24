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

  //----------------------------------------------------------------------------
  // MARK: - Equatable
  //----------------------------------------------------------------------------

  static func ==(_ lhs: PDBLigand, _ rhs: PDBLigand) -> Bool {
    return lhs.name == rhs.name && lhs.atoms == rhs.atoms
  }
}

/*******************************************************************************
 * PDBLigandLight
 *
 * A light-weigth version of ligand informations from a PDB file
 *
 ******************************************************************************/
struct PDBLigandLight: Equatable {
  let name: String
  let atoms: [PDBAtomLight]

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(ligand: PDBLigand) {
    self.name = ligand.name
    self.atoms = ligand.atoms.map() { $0.lightAtom }
  }

  //----------------------------------------------------------------------------
  // MARK: - Equatable
  //----------------------------------------------------------------------------

  static func ==(_ lhs: PDBLigandLight, _ rhs: PDBLigandLight) -> Bool {
    return lhs.name == rhs.name && lhs.atoms == rhs.atoms
  }
}
