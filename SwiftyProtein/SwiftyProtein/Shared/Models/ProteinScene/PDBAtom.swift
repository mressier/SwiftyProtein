import UIKit
import SceneKit

/*******************************************************************************
 * Atom
 *
 * Informations about an atom
 *
 ******************************************************************************/
struct PDBAtom: Hashable {
  let index: Int
  let symbol: String
  let position: PDBAtomPosition
  let linkedAtoms: [Int]

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(index: Int,
       symbol: String? = nil,
       position: PDBAtomPosition,
       linkedAtoms: [Int]) {
    self.index = index
    self.symbol = symbol ?? "\(index)"
    self.position = position
    self.linkedAtoms = linkedAtoms
  }

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  /******************** Conversion ********************/

  var positionSCN: SCNVector3 {
    return position.toSCNVector3
  }

  /******************** Overr ********************/

  static func == (lhs: PDBAtom, rhs: PDBAtom) -> Bool {
    return lhs.index == rhs.index && lhs.symbol == rhs.symbol
  }
}
