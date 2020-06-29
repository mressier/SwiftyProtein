import UIKit

struct LigandSceneConfiguration {
  var colorMode: ColorMode
  var distanceMultiplier: Float = 1.5

  static var `default` = LigandSceneConfiguration(colorMode: .cpk)

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  func getColor(for atom: PDBAtomLight) -> UIColor {
    return colorMode.color(for: atom)
  }
}
