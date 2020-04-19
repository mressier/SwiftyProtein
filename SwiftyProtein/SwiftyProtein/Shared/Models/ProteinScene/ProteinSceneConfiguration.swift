import UIKit

struct ProteinSceneConfiguration {
  var colorMode: ColorMode

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  func getColor(for atom: PDBAtomLight) -> UIColor {
    return colorMode.color(for: atom)
  }
}
