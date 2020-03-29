//
//  SCNNode+Atom.swift
//  SwiftyProtein
//
//  Created by Mathilde Ressier on 28/03/2020.
//  Copyright © 2020 Mathilde Ressier. All rights reserved.
//

import Foundation
import SceneKit

extension SCNNode {

  /// Create nodes for atoms with their positions, color and text in the current node
  @discardableResult
  func createAtomNodes(forAtoms atoms: [Atom]) -> [AtomNode] {
    var nodes = [AtomNode]()

    for atom in atoms {
      if let sphere = self.addSphere(color: atom.color, at: atom.positionSCN) {
        let _ = sphere.addText(atom.name,
                               color: .black,
                               at: SCNVector3(0.0, 0.0, 0.0))

        nodes.append(AtomNode(atom: atom, node: sphere))
      }
    }
    return nodes
  }

  /// Create links as cylinder between atom pairs
  @discardableResult
  func createLinks(between nodesPairs: [AtomPair]) -> [SCNNode] {
    var links = [SCNNode]()

    for nodePair in nodesPairs {
      if let cylinder = self.addCylinderBetween(nodePair.start.node,
                                                and: nodePair.end.node,
                                                color: .cyan)
      { links.append(cylinder) }
    }

    print(nodesPairs.map() { return "\($0.start.index) -> \($0.end.index)" })
    return links
  }

}
