import Foundation
import SceneKit

class SCNLigandNode: SCNNode {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private(set) var atomNodes: [SCNAtomNode] = []
  private(set) var links: [SCNNode] = []

  private var atomNodesByNode: [SCNNode: SCNAtomNode] = [:]

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  func create(ligand: LigandGraphicData) {
    atomNodes = createNodes(for: ligand)
    atomNodesByNode = atomNodes.dictionaryByNode

    let pairs = atomNodes.extractAtomPairs()
    links = createLinks(betweenAtoms: pairs)
  }

  func removeLigand() {
    atomNodes.forEach() { $0.removeFromParentNode() }
    atomNodes = []
    atomNodesByNode = [:]
    links.forEach() { $0.removeFromParentNode() }
    links = []
  }

  //----------------------------------------------------------------------------
  // MARK: - Selection
  //----------------------------------------------------------------------------

  func toggleSelection(on node: SCNNode) -> SCNAtomNode? {
    guard let isSelected =
      atomNodesByNode[node]?.atom.isSelected else { return nil }

    atomNodesByNode[node]?.setSelected(!isSelected)
    return atomNodesByNode[node]
  }

  //----------------------------------------------------------------------------
  // MARK: - Nodes creation
  //----------------------------------------------------------------------------

  private func createNodes(for ligand: LigandGraphicData) -> [SCNAtomNode] {
    let nodes = ligand.atoms.compactMap() { SCNAtomNode(atom: $0) }
    nodes.forEach() { self.addChildNode($0) }
    return nodes
  }

  private func createLinks(betweenAtoms atoms: [AtomPair]) -> [SCNNode] {
    return atoms.compactMap() { pair in
      return addCylinderBetween(pair.start,
                                and: pair.end,
                                color: .black)
    }
  }
}
