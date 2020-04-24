import SceneKit

/*******************************************************************************
 * PDBPDBAtomPosition
 *
 * Position in 3d of an atom
 *
 ******************************************************************************/
struct PDBAtomPosition: Hashable {
  let x: CGFloat
  let y: CGFloat
  let z: CGFloat

  var toSCNVector3: SCNVector3 {
    return SCNVector3(x, y, z)
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(x: CGFloat, y: CGFloat, z: CGFloat, mult: CGFloat = 1.0) {
    self.x = x * mult
    self.y = y * mult
    self.z = z * mult
  }

  init(x: Float, y: Float, z: Float) {
    self.init(x: CGFloat(x), y: CGFloat(y), z: CGFloat(z))
  }

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  /******************** Multiplied ********************/

  func multiplied(by value: CGFloat) -> PDBAtomPosition {
    return PDBAtomPosition(x: x, y: y, z: z, mult: value)
  }

  /******************** Equatable ********************/

  static func == (lhs: PDBAtomPosition, rhs: PDBAtomPosition) -> Bool {
    return rhs.x == lhs.x && rhs.y == lhs.y && rhs.z == lhs.z
  }
}

