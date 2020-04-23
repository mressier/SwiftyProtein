import UIKit
import SceneKit

/*******************************************************************************
 * PDBAtomLight
 *
 * Represent a light version of an atom with only informations required to display it.
 *
 ******************************************************************************/
struct PDBAtomLight: Hashable {
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

  /******************** Equatable ********************/

  static func == (lhs: PDBAtomLight, rhs: PDBAtomLight) -> Bool {
    return lhs.index == rhs.index && lhs.symbol == rhs.symbol
  }
}
