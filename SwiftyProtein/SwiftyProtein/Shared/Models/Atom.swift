import UIKit
import SceneKit

/*******************************************************************************
 * AtomPosition
 *
 * Position in 3d of an atom
 *
 ******************************************************************************/
struct AtomPosition: Hashable {
  let x: CGFloat
  let y: CGFloat
  let z: CGFloat

  var toSCNVector3: SCNVector3 {
    return SCNVector3(x, y, z)
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(x: CGFloat,
       y: CGFloat,
       z: CGFloat,
       mult: CGFloat = 1.0) {
    self.x = x * mult
    self.y = y * mult
    self.z = z * mult
  }

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  static func == (lhs: AtomPosition, rhs: AtomPosition) -> Bool {
    return rhs.x == lhs.x && rhs.y == lhs.y && rhs.z == lhs.z
  }
}

/*******************************************************************************
 * Atom
 *
 * Informations about an atom
 *
 ******************************************************************************/
struct Atom: Hashable {
  let index: Int
  let symbol: String
  let position: AtomPosition
  let linkedAtoms: [Int]

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(index: Int,
       symbol: String? = nil,
       position: AtomPosition,
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

  static func == (lhs: Atom, rhs: Atom) -> Bool {
    return lhs.index == rhs.index && lhs.symbol == rhs.symbol
  }
}
