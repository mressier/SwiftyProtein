import SceneKit

/*******************************************************************************
 * PDBPDBAtomPosition
 *
 * Position in 3d of an atom
 *
 ******************************************************************************/
struct PDBAtomPosition: Hashable {
  var x: CGFloat
  var y: CGFloat
  var z: CGFloat

  /******************** Conversion ********************/

  var toSCNVector3: SCNVector3 {
    return SCNVector3(x, y, z)
  }

  /******************** Static ********************/

  static var zero: PDBAtomPosition {
    return PDBAtomPosition(x: 0.0, y: 0.0, z: 0.0)
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

  init(copy: PDBAtomPosition) {
    self.x = copy.x
    self.y = copy.y
    self.z = copy.z
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

