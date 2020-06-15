import Foundation

struct LigandGraphicData {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let atoms: [AtomGraphicData]

  //----------------------------------------------------------------------------
  // MARK: - Initialize
  //----------------------------------------------------------------------------

  init(atoms: [PDBAtomLight], config: LigandSceneConfiguration) {
    self.atoms = atoms.map() { lightAtom -> AtomGraphicData in
      let position =
        lightAtom.position.multiplied(by: config.distanceMultiplier)

      let atom = AtomGraphicData(index: lightAtom.index,
                                 position: position.toSCNVector3,
                                 color: config.getColor(for: lightAtom),
                                 name: lightAtom.symbol,
                                 linkedAtomIndexes: lightAtom.linkedAtoms)
      return atom
    }
  }
}
