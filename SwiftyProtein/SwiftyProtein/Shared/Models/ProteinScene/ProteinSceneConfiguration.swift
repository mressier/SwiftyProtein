import UIKit

struct ProteinSceneConfiguration {
  var colorMode: ColorMode
  var distanceMultiplier = CGFloat(3.0)

  static var `default` = ProteinSceneConfiguration(colorMode: .cpk)

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  func getColor(for atom: PDBAtomLight) -> UIColor {
    return colorMode.color(for: atom)
  }
}
