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
    let distance = PDBAtomPosition(x: area.max.x - area.min.x,
                                   y: area.max.y - area.min.y,
                                   z: area.max.z - area.min.z)
    let highest = [distance.x, distance.y, distance.z].highest ?? -30

    let y = Float(highest * -3)
    let clampedY = y.clamped(min: -70, max: 70)

    position = SCNVector3(x: 0, y: clampedY, z: 0)
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
