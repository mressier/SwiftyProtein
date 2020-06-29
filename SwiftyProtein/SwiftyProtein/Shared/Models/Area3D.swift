import Foundation
import SceneKit

/*******************************************************************************
 * Area3D
 *
 * Represent an area in space, starting a min and ending at max
 *
 ******************************************************************************/
class Area3D {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var min: SCNVector3
  var max: SCNVector3

  /******************** Computed ********************/

  var distance: SCNVector3 {
    return SCNVector3(x: max.x - min.x,
                      y: max.y - min.y,
                      z: max.z - min.z)
  }

  var middle: SCNVector3 {
    return SCNVector3(x: max.x - (distance.x / 2),
                      y: max.y - (distance.y / 2),
                      z: max.z - (distance.z / 2))
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(min: SCNVector3, max: SCNVector3) {
    self.min = SCNVector3(min.x, min.y, min.z)
    self.max = SCNVector3(max.x, max.y, max.z)
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func update(min compare: SCNVector3) {
    min.x = Swift.min(compare.x, min.x)
    min.y = Swift.min(compare.y, min.y)
    min.z = Swift.min(compare.z, min.z)
  }

  func update(max compare: SCNVector3) {
    max.x = Swift.max(compare.x, max.x)
    max.y = Swift.max(compare.y, max.y)
    max.z = Swift.max(compare.z, max.z)
  }
}

extension Area3D: CustomStringConvertible {
  var description: String {
    return "{min: \(min) -> max: \(max)}"
  }
}
