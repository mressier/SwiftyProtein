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

  var ligand: SCNLigandNode?

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

    let ligand = SCNLigandNode()
    viewNode.addChildNode(ligand)
    self.ligand = ligand
//    startAutoAnimation(on: viewNode)
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

  func reload() {
    ligand?.removeLigand()
    ligand?.create(ligand: LigandGraphicData(atoms: atoms,
                                             config: configuration))

    setCameraPosition(forNodes: ligand?.atomNodes ?? [])
  }

  private func setCameraPosition(forNodes nodes: [SCNAtomNode]) {
    let area = nodes.areaCovered
    let distance = PDBAtomPosition(x: area.max.x - area.min.x,
                                   y: area.max.y - area.min.y,
                                   z: area.max.z - area.min.z)
    let highest = [distance.x, distance.y, distance.z].highest ?? -30

    let y = Float(highest * -3)
    let clampedY = y.clamped(min: -70, max: 70)

    cameraNode.position = SCNVector3(x: 0, y: clampedY, z: 0)
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

    guard let atomNode = sceneView.getNode(at: location),
      let atomData = ligand?.toggleSelection(on: atomNode),
      let atom = atoms.first(where: { $0.index == atomData.atom.index }) else {
        return
    }

    atomData.atom.isSelected ? didSelectAtom?(atom) : didUnselectAtom?()
  }
}
