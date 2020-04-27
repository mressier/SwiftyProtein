import Foundation

struct LigandsAppList {
  var ligands: [String]
  var favorites: [String]

  //----------------------------------------------------------------------------
  // MARK: - Sections
  //----------------------------------------------------------------------------

  let alphabetical = "abcdefghijklmnopqrstuvwxyz0123456789".uppercased()

  //----------------------------------------------------------------------------
  // MARK: - Convert to collection
  //----------------------------------------------------------------------------

  typealias SectionSourceContent =
    LigandCollectionViewController.LigandSectionSource.SectionSourceContent

  private var ligandsToSections: [SectionSourceContent] {
    return alphabetical.map() { character -> SectionSourceContent in
      let character = String(character)

      let ligandsForCharacter = ligands.filter() { ligand in
        ligand.starts(with: character)
          || ligand.starts(with: character.lowercased())
      }

      let convertedLigands = ligandsForCharacter.map() {
        LigandCollection.Ligand(name: $0)
      }

      return (section: LigandCollection.Header(title: character, image: nil),
              content: convertedLigands)
    }
  }

  private var favoritesToSection: SectionSourceContent {
    let favoriteCollection =
      favorites.map() { LigandCollection.Ligand(name: $0) }
    return (section: LigandCollection.Header(title: "",
                                             image: SPAssets.heartFilled.image),
            content: favoriteCollection)
  }

  /// Convert all ligands to a collection
  var toLigandCollection: [SectionSourceContent] {
    return [favoritesToSection] + ligandsToSections
  }
}
