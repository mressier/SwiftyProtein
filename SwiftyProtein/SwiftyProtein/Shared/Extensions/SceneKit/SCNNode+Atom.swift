//
//  SCNNode+Atom.swift
//  SwiftyLigand
//
//  Created by Mathilde Ressier on 28/03/2020.
//  Copyright © 2020 Mathilde Ressier. All rights reserved.
//

import Foundation
import SceneKit

extension SCNNode {

  /// Create nodes for atoms with their positions, color and text in the current node
  @discardableResult
  func createAtomNodes(
    forAtoms atoms: [PDBAtomLight],
    config: LigandSceneConfiguration = .default
  ) -> [AtomNode] {
    var nodes = [AtomNode]()

    for atom in atoms {
      let color = config.getColor(for: atom)
      let position = atom.position.multiplied(by: config.distanceMultiplier)

      if let sphere = self.addSphere(color: color, at: position.toSCNVector3) {
        sphere.constraintToLookAtPointOfView()
        _ = sphere.addText(atom.symbol, color: .black, at: .zero)

        nodes.append(AtomNode(atom: atom, node: sphere))
      }
    }

    return nodes
  }

//  private func testMaterial(addOn node: SCNNode) {
//    let material = SCNMaterial()
//    material.
//  }

  /// Create links as cylinder between atom pairs
  @discardableResult
  func createLinks(between nodesPairs: [AtomPair]) -> [SCNNode] {
    var links = [SCNNode]()

    for nodePair in nodesPairs {
      if let cylinder =
        self.addCylinderBetween(nodePair.start.node,
                                and: nodePair.end.node,
                                color: .black)
      { links.append(cylinder) }
    }
    return links
  }

}
