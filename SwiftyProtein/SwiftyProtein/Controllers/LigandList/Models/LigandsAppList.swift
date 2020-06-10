import Foundation

struct LigandsAppList {
  var ligands: [String]
  var favorites: [String]

  //----------------------------------------------------------------------------
  // MARK: - Sections
  //----------------------------------------------------------------------------

  static let alphabetical: [String] =
    "abcdefghijklmnopqrstuvwxyz0123456789".uppercased().map() { String($0) }

  func filtered(isIncluded: @escaping ((String) -> Bool)) -> LigandsAppList {
    let ligands = self.ligands.filter(isIncluded)
    let favorites = self.favorites.filter(isIncluded)
    return LigandsAppList(ligands: ligands, favorites: favorites)
  }
}
