import UIKit
import SceneKit

/*******************************************************************************
 * SCNCameraNode
 *
 * Node with integrated camera.
 *
 ******************************************************************************/
class SCNCameraNode: SCNNode {

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /// Arrange camera position to have a complete overview of a ligand.
  func look(at ligand: SCNLigandNode?) {
    guard let nodes = ligand?.atomNodes else { return }

    let area = nodes.areaCovered
    let distance = area.distance
    let middle = area.middle

    let higherDistance = CGFloat(max(distance.x, distance.z) * 3)
    let clampedHigherDistance = higherDistance.clamped(min: -70, max: 70)
    let y = CGFloat(CGFloat(area.max.y) - clampedHigherDistance)

    position = SCNVector3(0, y, 0)
  }

  func resetPosition() {
    position = .zero
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  func setupCamera() {
    self.camera = SCNCamera()
    self.position = .zero
  }

}
