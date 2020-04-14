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

  func color(for atom: Atom)  -> UIColor {
    guard let atomInfo = AtomInfo.knownAtomsBySymbol[atom.symbol] else {
      return defaultColor
    }

    switch self {
    case .cpk: return atomInfo.cpkColor
    }
  }
}
