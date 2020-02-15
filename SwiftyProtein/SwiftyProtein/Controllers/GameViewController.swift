import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  private var sceneView: SCNView!
  private var scene: SCNScene!
  private var cameraNode: SCNNode!

  /******************** UI Parameters ********************/

  override var shouldAutorotate: Bool { return true }
  override var prefersStatusBarHidden: Bool { return true }

  /******************** Parameters ********************/

  /// Atoms to show on the scene
  var atoms = AtomBuilder.build()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let nodes = createNodes(forAtoms: atoms, on: scene.rootNode)
    createLinks(between: nodes.extractAtomPairs(), on: scene.rootNode)
  }

  private func setup() {
    setupSceneView()
    setupScene()
    setupLight(on: scene)
    setupCamera(on: scene)

    constraintCamera(cameraNode, toLookAt: scene.rootNode)
  }

  private func setupSceneView() {
    sceneView = self.view as? SCNView
  }

  private func setupScene() {
    scene = SCNScene()
    sceneView.scene = scene
    sceneView.allowsCameraControl = true
  }

  private func setupCamera(on scene: SCNScene) {
    let camera = SCNCamera()

    cameraNode = SCNNode()
    cameraNode.camera = camera
    cameraNode.position = SCNVector3(x: 0.0, y: 0.0, z: 5.0)

    scene.rootNode.addChildNode(cameraNode)
  }

  private func setupLight(on scene: SCNScene) {
    let light = SCNLight()
    light.type = SCNLight.LightType.omni

    let lightNode = SCNNode()
    lightNode.light = light
    lightNode.position = SCNVector3(x: -10.0, y: 10.0, z: 0.0)

    scene.rootNode.addChildNode(lightNode)
  }

  //----------------------------------------------------------------------------
  // MARK: - Scene content
  //----------------------------------------------------------------------------

  private func constraintCamera(_ camera: SCNNode, toLookAt node: SCNNode) {
    let constraint = SCNLookAtConstraint(target: node)
    constraint.isGimbalLockEnabled = true
    camera.constraints = [constraint]
  }

  /******************** Links ********************/

  private func createLinks(between nodesPairs: [AtomPair],
                           on rootNode: SCNNode) -> [SCNNode] {
    var links = [SCNNode]()

    for nodePair in nodesPairs {
      if let cylinder = rootNode.addCylinderBetween(nodePair.start.node,
                                                    and: nodePair.end.node,
                                                    color: .cyan) {
        links.append(cylinder)
      }
    }

    return links
  }

  /******************** Spheres ********************/

  private func createNodes(forAtoms atoms: [Atom],
                           on rootNode: SCNNode) -> [AtomNode] {
    var nodes = [AtomNode]()

    for atom in atoms {
      if let sphere = rootNode.addSphere(color: atom.color,
                                         at: atom.positionSCN) {
        nodes.append(AtomNode(atom: atom, node: sphere))
      }
    }

    return nodes
  }

}
