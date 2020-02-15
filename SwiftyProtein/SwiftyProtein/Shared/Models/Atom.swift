import UIKit
import SceneKit

struct AtomPosition {
  let x: CGFloat
  let y: CGFloat
  let z: CGFloat

  var toSCNVector3: SCNVector3 {
    return SCNVector3(x, y, z)
  }
}

struct Atom {
  let index: Int
  let name: String
  let position: AtomPosition
  let linkedAtoms: [Int]
  let color: UIColor?

  /******************** Conversion ********************/

  var positionSCN: SCNVector3 {
    return position.toSCNVector3
  }
}
