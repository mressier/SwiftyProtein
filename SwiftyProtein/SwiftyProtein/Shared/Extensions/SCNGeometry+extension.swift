import Foundation
import SceneKit
import UIKit

extension SCNGeometry {

  /// Add a color as a material on the geometry
  func add(color: UIColor?) {
    guard let color = color else { return }

    let material = SCNMaterial()
    material.diffuse.contents = color
    materials = [material]
  }
}
