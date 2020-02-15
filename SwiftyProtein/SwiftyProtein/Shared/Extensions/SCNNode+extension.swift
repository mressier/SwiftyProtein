import Foundation
import SceneKit

extension SCNNode {

  //----------------------------------------------------------------------------
  // MARK: - Geometry
  //----------------------------------------------------------------------------

  /// Add a cylinder geometry as a node
  func addCylinder(height: CGFloat,
                   color: UIColor? = nil,
                   at position: SCNVector3? = nil) -> SCNNode? {
    let cylinder = SCNCylinder(radius: 0.2, height: height)
    let cylinderNode = SCNNode(geometry: cylinder)

    cylinder.add(color: color)

    addChildNode(cylinderNode)
    return cylinderNode
  }

  /// Add a sphere geometry as a node
  func addSphere(color: UIColor? = nil,
                 at position: SCNVector3? = nil) -> SCNNode? {
    let sphere = SCNSphere()
    let node = SCNNode(geometry: sphere)

    sphere.add(color: color)

    if let position = position {
      node.position = position
    }

    addChildNode(node)
    return node
  }

  /// Create a cylinder that represent a physical link between two nodes
  /// - Parameters:
  ///   - source: node to use as source of the link
  ///   - destination: node to use as destination of the link
  ///   - color: color of the cylinder
  func addCylinderBetween(_ source: SCNNode,
                          and destination: SCNNode,
                          color: UIColor? = nil) -> SCNNode? {
    let height = source.distance(to: destination)

    let pathAlignedNode = SCNNode()
    pathAlignedNode.eulerAngles.x = .pi / 2

    let nodeCylinder = pathAlignedNode.addCylinder(height: height,
                                                   color: color)
    nodeCylinder?.position.y = Float(-height / 2)

    source.addChildNode(pathAlignedNode)
    source.constraints = [SCNLookAtConstraint(target: destination)]

    return nodeCylinder
  }

  //----------------------------------------------------------------------------
  // MARK: - Maths
  //----------------------------------------------------------------------------

  func distance(to receiver: SCNNode) -> CGFloat {
    let source = position
    let destination = receiver.position
    let xDifference = destination.x - source.x
    let yDifference = destination.y - source.y
    let zDifference = destination.z - source.z

    let distance = Float(sqrt(
      xDifference * xDifference
        + yDifference * yDifference
        + zDifference * zDifference
    ))

    return distance < 0 ? CGFloat(distance * -1) : CGFloat(distance)
  }
}
