import Foundation
import SceneKit
import UIKit

extension SCNGeometry {

  var color: UIColor? {
    return materials.first?.diffuse.contents as? UIColor
  }

  /// Add a color as a material on the geometry
  func add(color: UIColor?) {
    guard let color = color else { return }

    let material = SCNMaterial()
    material.diffuse.contents = color
    materials = [material]
  }
}
