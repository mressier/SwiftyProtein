import Foundation
import SceneKit

extension SCNVector3 {

  /******************** Init ********************/

  init(x: Float, y: Float, z: Float, mult: Float = 1.0) {
    self.init(x * mult, y * mult, z * mult)
  }

  /******************** Default values ********************/

  static var zero: SCNVector3 {
    return SCNVector3(0, 0, 0)
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------
  
  func difference(to destination: SCNVector3) -> SCNVector3 {
      let xDifference = destination.x - self.x
      let yDifference = destination.y - self.y
      let zDifference = destination.z - self.z

      return SCNVector3(xDifference, yDifference, zDifference)
  }

  func distance(to destination: SCNVector3) -> CGFloat {
      let diff = difference(to: destination)

      let distance = Float(sqrt(
        diff.x * diff.x
          + diff.y * diff.y
          + diff.z * diff.z
      ))

      return distance < 0 ? CGFloat(distance * -1) : CGFloat(distance)
  }

  func multiplied(by value: Float) -> SCNVector3 {
    return SCNVector3(x: x, y: y, z: z, mult: value)
  }
}

//==============================================================================
// MARK: - Hashable
//==============================================================================

extension SCNVector3: Hashable {
  public static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
    hasher.combine(z)
  }
}
