import Foundation
import SceneKit

/*******************************************************************************
 * AtomNode
 *
 * Atom representation on a view with a node
 *
 ******************************************************************************/
struct AtomNode {
  let atom: PDBAtomLight
  let node: SCNNode

  var isSelected: Bool = false

  //----------------------------------------------------------------------------
  // MARK: - Computed
  //----------------------------------------------------------------------------

  var index: Int { return atom.index }

  var linkedAtoms: [Int] { return atom.linkedAtoms }

  static func ==(lhs: AtomNode, rhs: AtomNode) -> Bool {
    return lhs.node == rhs.node && lhs.atom == rhs.atom
  }
}

extension AtomNode: CustomStringConvertible {
  var description: String {
    return "\(index)"
  }
}
