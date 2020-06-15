import Foundation
import SceneKit

extension SCNVector3 {
  static var zero: SCNVector3 {
    return SCNVector3(0, 0, 0)
  }

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
}
