import UIKit
import SceneKit

/*******************************************************************************
 * PDBAtomLight
 *
 * Represent a light version of an atom with only informations required to display it.
 *
 ******************************************************************************/
struct PDBAtomLight: Hashable, Positionable3D {
  let index: Int
  let symbol: String
  var position: SCNVector3
  let linkedAtoms: [Int]

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(index: Int,
       symbol: String? = nil,
       position: SCNVector3,
       linkedAtoms: [Int]) {
    self.index = index
    self.symbol = symbol ?? "\(index)"
    self.position = position
    self.linkedAtoms = linkedAtoms
  }

  //----------------------------------------------------------------------------
  // MARK: - Equatable
  //----------------------------------------------------------------------------

  static func == (lhs: PDBAtomLight, rhs: PDBAtomLight) -> Bool {
    return lhs.index == rhs.index && lhs.symbol == rhs.symbol
  }
}
