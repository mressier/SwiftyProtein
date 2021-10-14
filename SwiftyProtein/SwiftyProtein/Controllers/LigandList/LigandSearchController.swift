import UIKit

class LigandSearchController: UISearchController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Source ********************/

  var ligandsList = LigandsAppList(ligands: [], favorites: [])

  private var lastSearch = ""
  private var lastList: LigandsAppList?

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  //----------------------------------------------------------------------------
  // MARK: - Search tools
  //----------------------------------------------------------------------------

  /// Return a collection with elements that match the search text
  func getLigandsList(withSearchText text: String) -> LigandsAppList {
    let text = text.trimmed()
    if text.isEmpty { return ligandsList }

    let startingList = getLigandsList(toSearch: text)
    let list = startingList.filtered(isIncluded: { $0.contains(text) })

    saveCurrentSearch(text: text, ligandsList: list)
    return list
  }

  //----------------------------------------------------------------------------
  // MARK: - Get and save ligands lists
  //----------------------------------------------------------------------------

  /// Get ligand list to use to search the text
  private func getLigandsList(toSearch text: String) -> LigandsAppList {
    if text.count > lastSearch.count, let lastList = lastList {
      return lastList
    }
    return ligandsList
  }

  private func saveCurrentSearch(text: String, ligandsList: LigandsAppList) {
    lastList = ligandsList
    lastSearch = text
  }
}
