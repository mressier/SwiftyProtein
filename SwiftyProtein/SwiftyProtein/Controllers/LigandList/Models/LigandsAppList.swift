import Foundation

struct LigandsAppList {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var ligands: [String]
  var favorites: [String]

  //----------------------------------------------------------------------------
  // MARK: - Static
  //----------------------------------------------------------------------------

  static let alphabetical: [String] =
    "abcdefghijklmnopqrstuvwxyz0123456789".uppercased().map() { String($0) }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func filtered(isIncluded: @escaping ((String) -> Bool)) -> LigandsAppList {
    let ligands = self.ligands.filter(isIncluded)
    let favorites = self.favorites.filter(isIncluded)
    return LigandsAppList(ligands: ligands, favorites: favorites)
  }

  func contains(ligand: String) -> Bool {
    return self.ligands.contains(where: { $0 == ligand })
    || self.favorites.contains(where: { $0 == ligand })
  }
}
