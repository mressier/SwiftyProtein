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

  /******************** UI Parameters ********************/

  override var prefersStatusBarHidden: Bool { return true }

  var configuration = ProteinSceneConfiguration(colorMode: .cpk)

  /******************** Protein Parameters ********************/

  /// Atoms to show on the scene
  var atoms = [PDBAtomLight]()

  private var atomsDictionary = [SCNNode: AtomNode]()

  /********************  Callbacks  ********************/

  var didSelectAtom: ((PDBAtomLight) -> Void)?
  var didUnselectAtom: (() -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
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
    sceneView.autoenablesDefaultLighting = true
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
  // MARK: - Reload
  //----------------------------------------------------------------------------

  func reload() {
    for atomNode in atomsDictionary.values {
      atomNode.node.removeFromParentNode()
    }

    let atomNodes = viewNode.createAtomNodes(forAtoms: atoms,
                                             config: configuration)
    viewNode.createLinks(between: atomNodes.extractAtomPairs())

    atomsDictionary = atomNodes.dictionaryByNode
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
    let color = configuration.getColor(for: atomNode.atom)
    atomsDictionary[node]?.node.geometry?.add(color: isSelected ? color.withAlphaComponent(0.7) : color)

    isSelected ? didSelectAtom?(atomNode.atom) : didUnselectAtom?()
  }
}
