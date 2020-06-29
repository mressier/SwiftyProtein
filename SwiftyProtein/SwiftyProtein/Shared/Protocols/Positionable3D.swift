import SceneKit

/*******************************************************************************
 * Positionable
 *
 * For objects that can be placed in a point in 3 dimensions
 *
 ******************************************************************************/
protocol Positionable3D {
  var position: SCNVector3 { get set }
}

//==============================================================================
// MARK: - Array + Positionable
//==============================================================================

extension Array where Element: Positionable3D {
  var areaCovered: Area3D {
    let firstPosition = self.first?.position
    let area = Area3D(min: firstPosition ?? .zero,
                      max: firstPosition ?? .zero)

    self.forEach() { element in
      area.update(min: element.position)
      area.update(max: element.position)
    }

    return area
  }
}
