import UIKit

enum ColorMode {
  case cpk

  /******************** Computed ********************/

  var defaultColor: UIColor {
    switch self {
    case .cpk: return AtomInfo.defaultCPKColor
    }
  }

  /******************** Tools ********************/

  func color(for atom: PDBAtomLight)  -> UIColor {
    guard let atomInfo = AtomsList.atomsBySymbol[atom.symbol] else {
      return defaultColor
    }

    switch self {
    case .cpk: return atomInfo.cpkColor
    }
  }
}
