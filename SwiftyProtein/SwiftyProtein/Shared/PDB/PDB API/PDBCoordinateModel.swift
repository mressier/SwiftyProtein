import Foundation

enum PDBCoordinateModel {
  case experimental
  case ideal

  var urlExtension: String {
    switch self {
    case .experimental: return "model"
    case .ideal: return "ideal"
    }
  }
}
