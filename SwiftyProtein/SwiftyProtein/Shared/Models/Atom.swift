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
  let name: String
  let position: AtomPosition
  let linkedAtoms: [Int]
  let color: UIColor?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(index: Int,
       name: String? = nil,
       position: AtomPosition,
       linkedAtoms: [Int],
       color: UIColor?) {
    self.index = index
    self.name = name ?? "\(index)"
    self.position = position
    self.linkedAtoms = linkedAtoms
    self.color = color
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
    return lhs.index == rhs.index && lhs.name == rhs.name
  }
}
