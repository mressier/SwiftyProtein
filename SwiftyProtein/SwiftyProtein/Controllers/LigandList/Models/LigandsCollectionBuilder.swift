import Foundation

struct LigandsCollectionBuilder {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private static let favoriteImage = SPAssets.heartFilled.image

  //----------------------------------------------------------------------------
  // MARK: - Builder
  //----------------------------------------------------------------------------

  /// Build a complete ligand collection from a LigandsAppList
  static func build(
    from ligandsList: LigandsAppList
  ) -> LigandSectionSource.Sections {
    let alphabeticals = buildList(from: ligandsList.ligands,
                              alphabeticSections: LigandsAppList.alphabetical,
                              favoriteList: ligandsList.favorites)
    let favorites = buildFavorites(from: ligandsList.favorites)
    return favorites + alphabeticals
  }

  /// Build sections for a ligand list
  /// Each section match an element of `alphabeticSections`
  /// Section content is find by getting all element fron ligandsList that starts with the section name
  static func buildList(
    from ligandsList: [String],
    alphabeticSections: [String],
    favoriteList: [String] = []
  ) -> LigandSectionSource.Sections {

    return alphabeticSections.map() { character in

      let ligandsInSection =
        ligandsList.filter(startingWith: character, ignoringCase: true)

      let ligandsForCollection =
        ligandsNamesToItems(ligands: ligandsInSection, favoriteList: favoriteList)

      return (section: LigandCollection.Header(title: character, image: nil),
              content: ligandsForCollection)

    }.filter() { $0.content.count > 0 }
  }

  /// Build favorite section with a given list of ligands
  static func buildFavorites(
    from ligandsList: [String]
  ) -> LigandSectionSource.Sections {

    let favoriteCollection =
      ligandsNamesToItems(ligands: ligandsList, favoriteList: ligandsList)

    guard favoriteCollection.count > 0 else { return [] }

    return [(section: LigandCollection.Header(title: "", image: favoriteImage),
             content: favoriteCollection)]
  }

  //----------------------------------------------------------------------------
  // MARK: - Tools
  //----------------------------------------------------------------------------

  private static func ligandsNamesToItems(ligands: [String],
                                         favoriteList: [String]) -> [LigandCollection.Ligand] {
    return ligands.map() { ligand -> LigandCollection.Ligand in
      let isFavorite = favoriteList.contains(ligand)
      return LigandCollection.Ligand(name: ligand, isFavorite: isFavorite)
    }.sorted(by: { $0.name < $1.name })
  }

}
