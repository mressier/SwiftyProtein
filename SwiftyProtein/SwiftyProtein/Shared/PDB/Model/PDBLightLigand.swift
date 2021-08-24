import Foundation
import SceneKit

/*******************************************************************************
 * PDBLightLigand
 *
 * A light-weigth version of ligand informations from a PDB file
 *
 ******************************************************************************/
struct PDBLightLigand: Equatable {
  let name: String
  let coordinatesModel: PDBCoordinateModel
  let atoms: [PDBLightAtom]
  let isFavorite: Bool

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(ligand: PDBLigand, isFavorite: Bool) {
    self.name = ligand.name
    self.coordinatesModel = ligand.coordinatesModel
    self.atoms = ligand.atoms.map() { $0.lightAtom }
    self.isFavorite = isFavorite
  }

  init(name: String,
       coordinatesModel: PDBCoordinateModel,
       atoms: [PDBLightAtom],
       isFavorite: Bool) {
    self.name = name
    self.coordinatesModel = coordinatesModel
    self.atoms = atoms
    self.isFavorite = isFavorite
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /// Ligand with a position centered around the point 0
  func centered() -> PDBLightLigand {
    let area = atoms.areaCovered
    let middle = area.middle

    let centeredAtoms = atoms.map() { atom -> PDBLightAtom in
      let position = SCNVector3(x: atom.position.x - middle.x,
                                y: atom.position.y - middle.y,
                                z: atom.position.z - middle.z)

      return PDBLightAtom(index: atom.index,
                          symbol: atom.symbol,
                          position: position,
                          linkedAtoms: atom.linkedAtoms)
    }

    return PDBLightLigand(name: name,
                          coordinatesModel: coordinatesModel,
                          atoms: centeredAtoms,
                          isFavorite: isFavorite)
  }

  func numberOfAtoms(withSymbol atomSymbol: String) -> Int {
    return atoms.filter { $0.symbol == atomSymbol }.count
  }

  //----------------------------------------------------------------------------
  // MARK: - Equatable
  //----------------------------------------------------------------------------

  static func ==(_ lhs: PDBLightLigand, _ rhs: PDBLightLigand) -> Bool {
    return lhs.name == rhs.name
      && lhs.atoms == rhs.atoms
      && lhs.coordinatesModel == rhs.coordinatesModel
  }
}
