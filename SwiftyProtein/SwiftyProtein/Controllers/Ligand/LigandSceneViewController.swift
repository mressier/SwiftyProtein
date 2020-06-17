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
  private var cameraNode: SCNCameraNode!
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
    setupLigandNode(on: viewNode)
    setupGesture()
  }

  private func setupScene() {
    scene = SCNScene()
    sceneView.scene = scene
    sceneView.allowsCameraControl = true
  }

  private func setupCamera(on rootNode: SCNNode) {
    cameraNode = SCNCameraNode()

    rootNode.addChildNode(cameraNode)
    cameraNode.setupCamera()
    cameraNode.constraintToLookAt(rootNode)
  }

  private func setupLights(on scene: SCNScene) {
    sceneView.autoenablesDefaultLighting = true
  }

  private func setupViewNode(on rootNode: SCNNode) {
    viewNode = SCNNode()

    rootNode.addChildNode(viewNode)
//    startAutoAnimation(on: viewNode)
  }

  private func setupLigandNode(on rootNode: SCNNode) {
    let ligand = SCNLigandNode()
    rootNode.addChildNode(ligand)
    self.ligand = ligand
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

    cameraNode.look(at: ligand)
  }

  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

  @objc private func didTapOnScene(tap: UITapGestureRecognizer) {
    guard tap.state == .ended else { return }

    let location = tap.location(in: sceneView)

    guard let atomNode = sceneView.getNode(at: location) else {
      print("No node at \(location)")
      return
    }

    guard let atomData = ligand?.toggleSelection(on: atomNode) else {
      print("Node touched is not an atom")
      return
    }

    guard let atom =
      atoms.first(where: { $0.index == atomData.atom.index }) else {
        print("ERROR: Cannot found an atom with the same index as selected atom node")
        return
    }

    atomData.atom.isSelected ? didSelectAtom?(atom) : didUnselectAtom?()
  }
}
