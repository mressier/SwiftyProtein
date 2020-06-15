import Foundation
import SceneKit

extension SCNNode {

  //----------------------------------------------------------------------------
  // MARK: - Constraints
  //----------------------------------------------------------------------------

  func constraintToLookAt(_ node: SCNNode) {
    let constraint = SCNLookAtConstraint(target: node)
    constraint.isGimbalLockEnabled = true
    constraints = [constraint]
  }

  func constraintToLookAtPointOfView() {
    let constraint = SCNBillboardConstraint()
    constraints = [constraint]
  }

  //----------------------------------------------------------------------------
  // MARK: - Maths
  //----------------------------------------------------------------------------

  func distance(to receiver: SCNNode) -> CGFloat {
    return position.distance(to: receiver.position)
  }

  func difference(to receiver: SCNNode) -> SCNVector3 {
    return position.difference(to: receiver.position)
  }

  private func translateToCenter(of node: SCNNode) {
    let bounds = node.boundingBox

    let x = -bounds.min.x - ((bounds.max.x - bounds.min.x) / 2)
    let y = -bounds.min.y - ((bounds.max.y - bounds.min.y) / 2)
    let z = -bounds.min.z - ((bounds.max.z - bounds.min.z) / 2)

    node.position = SCNVector3(x, y, z)
  }
}

//==============================================================================
// MARK: - Geometries
//==============================================================================

extension SCNNode {

  /// Add a light object as a node
  func addLight(at position: SCNVector3) -> SCNNode? {
    let light = SCNLight()
    light.type = SCNLight.LightType.omni

    let lightNode = SCNNode()
    lightNode.light = light
    lightNode.position = position

    addChildNode(lightNode)

    return lightNode
  }

  /// Add a text geometry as a node
  func addText(_ string: String,
               color: UIColor? = nil,
               size: CGFloat = 0.3,
               at position: SCNVector3? = nil) -> SCNNode? {
    let text = SCNText(string: string, extrusionDepth: 0.1)
    text.font = text.font.withSize(size)
    text.add(color: color)
    let node = SCNNode(geometry: text)

    if let position = position {
      node.position = position
      translateToCenter(of: node)
    }

    addChildNode(node)
    return node
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

  /******************** Cylinder ********************/

  /// Add a cylinder geometry as a node
  func addCylinder(height: CGFloat,
                   color: UIColor? = nil,
                   at position: SCNVector3? = nil) -> SCNNode? {
    let cylinder = SCNCylinder(radius: 0.1, height: height)
    let cylinderNode = SCNNode(geometry: cylinder)

    cylinder.add(color: color)

    addChildNode(cylinderNode)
    return cylinderNode
  }

  /// Create a cylinder that represent a physical link between two nodes
  /// - Parameters:
  ///   - source: node to use as source of the link
  ///   - destination: node to use as destination of the link
  ///   - color: color of the cylinder
  func addCylinderBetween(_ source: SCNNode,
                          and destination: SCNNode,
                          color: UIColor? = nil) -> SCNNode? {
    if source.difference(to: destination).z > 0 {
      return addCylinderBetween(destination, and: source, color: color)
    }

    let radius = Float(0.5)
    let height = source.distance(to: destination) - CGFloat(radius * 2)

    let pathAlignedNode = SCNNode()
    pathAlignedNode.eulerAngles.x = .pi / 2

    let nodeCylinder = pathAlignedNode.addCylinder(height: height,
                                                   color: color)
    nodeCylinder?.position.y = Float(-height / 2) - radius

    let sourceChild = SCNNode()
    source.addChildNode(sourceChild)

    sourceChild.addChildNode(pathAlignedNode)
    sourceChild.constraintToLookAt(destination)

    return nodeCylinder
  }
}
