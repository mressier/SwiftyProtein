import UIKit
import QuartzCore
import SceneKit

class LigandSceneViewController: UIViewController {

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

  var configuration = LigandSceneConfiguration(colorMode: .cpk)

  private var cameraPosition: SCNVector3 = .zero

  /******************** Ligand Parameters ********************/

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
    cameraNode.position = cameraPosition

    rootNode.addChildNode(cameraNode)
    cameraNode.constraintToLookAt(rootNode)
  }

  private func setupLights(on scene: SCNScene) {
    sceneView.autoenablesDefaultLighting = true
  }

  private func setupViewNode(on rootNode: SCNNode) {
    viewNode = SCNNode()

    rootNode.addChildNode(viewNode)
    startAutoAnimation(on: viewNode)
  }

  private func setupGesture() {
    let selector = #selector(self.didTapOnScene)
    let tap = UITapGestureRecognizer(target: self, action: selector)
    sceneView.addGestureRecognizer(tap)
  }

  private func startAutoAnimation(on node: SCNNode) {
    let rotationAction = SCNAction.rotateBy(x: 0, y: 0.3, z: 0.3, duration: 1)
    let repeatRotationAction = SCNAction.repeatForever(rotationAction)
    node.runAction(repeatRotationAction)
  }

  private func stopAnimation(on node: SCNNode) {
    node.removeAllActions()
  }

  //----------------------------------------------------------------------------
  // MARK: - Reload
  //----------------------------------------------------------------------------

  func reload(completion: (() -> Void)?) {
    removeCurrentAtomNodes()

    let atomNodes = createAtomNodes(for: atoms)
    atomsDictionary = atomNodes.dictionaryByNode

    setCameraPosition(forNodes: atomNodes)

    completion?()
  }

  private func removeCurrentAtomNodes() {
    for atomNode in atomsDictionary.values {
      atomNode.node.removeFromParentNode()
    }
  }

  private func createAtomNodes(for atoms: [PDBAtomLight]) -> [AtomNode] {
    let atomNodes = viewNode.createAtomNodes(forAtoms: atoms,
                                             config: configuration)
    viewNode.createLinks(between: atomNodes.extractAtomPairs())
    return atomNodes
  }

  private func setCameraPosition(forNodes nodes: [AtomNode]) {
    let area = nodes.areaCovered
    let distance = PDBAtomPosition(x: area.max.x - area.min.x,
                                   y: area.max.y - area.min.y,
                                   z: area.max.z - area.min.z)
    let highest = [distance.x, distance.y, distance.z].highest ?? -30

    cameraNode.position = SCNVector3(x: 0, y: Float(highest) * -3, z: 0)
    cameraPosition = cameraNode.position
  }

  private func resetCameraPosition() {
    cameraNode.position = cameraPosition
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
    let geometryColor = isSelected ? color.withAlphaComponent(0.7) : color
    atomsDictionary[node]?.node.geometry?.add(color: geometryColor)

    isSelected ? didSelectAtom?(atomNode.atom) : didUnselectAtom?()
  }
}
