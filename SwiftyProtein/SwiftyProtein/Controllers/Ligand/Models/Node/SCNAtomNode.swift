import Foundation
import SceneKit

/*******************************************************************************
 * SCNAtomNode
 *
 * Custom class for a node representing an atom
 *
 ******************************************************************************/
class SCNAtomNode: SCNNode {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var atom: AtomGraphicData! {
    didSet { setupNodeAspect(with: atom) }
  }

  var nameText: SCNNode!

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(atom: AtomGraphicData) {
    super.init()
    self.atom = atom
    self.nameText = addText(atom.name, color: .black, at: .zero)
    setupNodeAspect(with: atom)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupNodeAspect(with atom: AtomGraphicData) {
    geometry = SCNSphere()
    geometry?.add(color: atom.color)
    position = atom.position
    constraintToLookAtPointOfView()
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func setSelected(_ isSelected: Bool) {
    atom.isSelected = isSelected

    let color = isSelected ? atom.color?.withAlphaComponent(0.7) : atom.color
    geometry?.add(color: color)
  }

  func getAtomPairs(to nodes: [SCNAtomNode]) -> [AtomPair] {
    nodes.map() { AtomPair(start: self, end: $0) }
  }
}
