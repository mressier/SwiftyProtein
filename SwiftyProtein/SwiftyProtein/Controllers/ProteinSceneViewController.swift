import UIKit
import QuartzCore
import SceneKit

class ProteinSceneViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak private var sceneView: SCNView!

  private var scene: SCNScene!
  private var cameraNode: SCNNode!
  private var viewNode: SCNNode!
  private var lights = [SCNNode]()

  /******************** UI Parameters ********************/

  override var prefersStatusBarHidden: Bool { return true }

  /******************** Protein Parameters ********************/

  /// Atoms to show on the scene
  var atoms = [Atom]()

  private var atomsDictionary = [SCNNode: AtomNode]()

  /********************  Callbacks  ********************/

  var didSelectAtom: ((Atom) -> Void)?
  var didUnselectAtom: (() -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    let atomNodes = viewNode.createAtomNodes(forAtoms: atoms)
    viewNode.createLinks(between: atomNodes.extractAtomPairs())

    atomsDictionary = atomNodes.dictionaryByNode
  }

  private func setup() {
    setupScene()
    setupLights(on: scene)
    setupCamera(on: scene.rootNode)
    setupViewNode(on: scene.rootNode)
    setupGesture()
  }

  private func setupScene() {
    scene = SCNScene()
    sceneView.scene = scene
    sceneView.allowsCameraControl = true
  }

  private func setupCamera(on rootNode: SCNNode) {
    let camera = SCNCamera()

    cameraNode = SCNNode()
    cameraNode.camera = camera
    cameraNode.position = SCNVector3(x: 0.0, y: -30.0, z: 0.0)

    rootNode.addChildNode(cameraNode)
    cameraNode.constraintToLookAt(rootNode)
  }

  private func setupLights(on scene: SCNScene) {
    let lightsPositions = [
      SCNVector3(x: -30.0, y: 10.0, z: 0.0),
      SCNVector3(x: 30.0, y: 10.0, z: 0.0)
    ]

    for position in lightsPositions {
      if let light = scene.rootNode.addLight(at: position) {
        lights.append(light)
      }
    }
  }

  private func setupViewNode(on rootNode: SCNNode) {
    viewNode = SCNNode()

    rootNode.addChildNode(viewNode)
  }

  private func setupGesture() {
    let selector = #selector(self.didTapOnScene)
    let tap = UITapGestureRecognizer(target: self, action: selector)
    sceneView.addGestureRecognizer(tap)
  }

  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

  @objc private func didTapOnScene(tap: UITapGestureRecognizer) {
    guard tap.state == .ended else { return }

    let location = tap.location(in: sceneView)

    guard let atomNode = sceneView.getNode(at: location) else { return }
    toggleAtomSelection(atomNode)
  }

  private func toggleAtomSelection(_ node: SCNNode) {
    guard let atomNode = atomsDictionary[node] else { return }
    let isSelected = !atomNode.isSelected

    atomsDictionary[node]?.isSelected = isSelected
    atomsDictionary[node]?.node.geometry?.add(color: atomNode.expectedColor)

    isSelected ? didSelectAtom?(atomNode.atom) : didUnselectAtom?()
  }
}
