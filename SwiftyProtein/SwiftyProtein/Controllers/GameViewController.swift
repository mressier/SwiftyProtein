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
  private var viewNode: SCNNode!

  /******************** UI Parameters ********************/

  override var shouldAutorotate: Bool { return true }
  override var prefersStatusBarHidden: Bool { return true }

  /******************** Parameters ********************/

  /// Atoms to show on the scene
  var atoms = AtomBuilder.build()
  var nodeAtoms = [AtomNode]()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    nodeAtoms = createNodes(forAtoms: atoms, on: viewNode)
    createLinks(between: nodeAtoms.extractAtomPairs(), on: viewNode)
  }

  private func setup() {
    setupSceneView()
    setupScene()
    setupLight(on: scene)
    setupCamera(on: scene.rootNode)
    setupViewNode(on: scene.rootNode)
    setupGesture()
  }

  private func setupSceneView() {
    sceneView = self.view as? SCNView
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

  private func setupLight(on scene: SCNScene) {
    scene.rootNode.addLight(at: SCNVector3(x: -30.0, y: 10.0, z: 0.0))
    scene.rootNode.addLight(at: SCNVector3(x: 30.0, y: 10.0, z: 0.0))
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

    guard let atomIndex = getAtomIndex(at: location) else { return }
    toggleAtomSelection(atomIndex: atomIndex)
  }

  /// Return the index on nodeAtoms array of the first node found at location
  private func getAtomIndex(at location: CGPoint) -> Int? {
    let hits = sceneView.hitTest(location, options: nil)

    if hits.isEmpty { return nil }

    let tappedNode = hits.first?.node
    let atomNodeIndex = nodeAtoms.firstIndex(where: { $0.node == tappedNode })

    return atomNodeIndex
  }

  private func toggleAtomSelection(atomIndex: Int) {
    let atom = nodeAtoms[atomIndex]

    nodeAtoms[atomIndex].isSelected = !atom.isSelected
    atom.node.geometry?.add(color: atom.expectedColor)
  }

  //----------------------------------------------------------------------------
  // MARK: - Scene content
  //----------------------------------------------------------------------------

  /******************** Links ********************/

  @discardableResult
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

  @discardableResult
  private func createNodes(forAtoms atoms: [Atom],
                           on rootNode: SCNNode) -> [AtomNode] {
    var nodes = [AtomNode]()

    for atom in atoms {
      if let sphere = rootNode.addSphere(color: atom.color,
                                         at: atom.positionSCN) {
        let _ = sphere.addText(atom.name,
                               color: .black,
                               at: SCNVector3(0.0, 0.0, 0.0))

        nodes.append(AtomNode(atom: atom, node: sphere))
      }

    }

    return nodes
  }

}
