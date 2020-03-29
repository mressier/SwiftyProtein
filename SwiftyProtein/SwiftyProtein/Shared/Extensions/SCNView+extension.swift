import Foundation
import SceneKit

extension SCNView {

  /// Return node at location in current scene view of nil if there is nothing
  func getNode(at location: CGPoint) -> SCNNode? {
    let hits = hitTest(location, options: nil)

    guard let tappedNode = hits.first?.node else { return nil }

    return tappedNode
  }
}
