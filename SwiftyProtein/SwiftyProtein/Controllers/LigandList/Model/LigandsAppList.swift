import Foundation

struct LigandsAppList {
  var ligands: [String]
  var favorites: [String]

  //----------------------------------------------------------------------------
  // MARK: - Sections
  //----------------------------------------------------------------------------

  static let alphabetical: [String] =
    "abcdefghijklmnopqrstuvwxyz0123456789".uppercased().map() { String($0) }
}
