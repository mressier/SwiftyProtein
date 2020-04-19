import UIKit

struct ProteinSceneConfiguration {
  var colorMode: ColorMode

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  func getColor(for atom: PDBAtom) -> UIColor {
    return colorMode.color(for: atom)
  }
}
