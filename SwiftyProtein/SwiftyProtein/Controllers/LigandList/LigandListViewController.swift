import UIKit

class LigandListViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var ligandListContainerView: UIView!

  /******************** Callbacks ********************/

  /******************** Parameters ********************/

  var ligandsList = LigandsAppList(ligands: [], favorites: []) {
    didSet {
      ligandCollection = LigandsCollectionBuilder.build(from: ligandsList)
    }
  }

  private var ligandCollection = LigandSectionSource.Sections()

  /******************** View Controllers ********************/

  private let searchController =
    UISearchController(searchResultsController: nil)

  private let ligandCollectionVC =
    LigandCollectionViewController(bundle: .main)

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    setupView()
    setupNavigationBar()
    setupSearchBar()
    setupLigandCollectionVC()
  }

  private func setupView() {
    definesPresentationContext = true
  }

  private func setupNavigationBar() {
    navigationItem.searchController = searchController
  }

  private func setupSearchBar() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search a ligand"
    searchController.searchBar.tintColor = .appTintColor
  }

  private func setupLigandCollectionVC() {
    ligandsList = LigandsAppList(ligands: FileReader.readLigandFile(),
                                  favorites: ["A", "B1"])

    ligandCollectionVC.ligandsList = ligandCollection

    add(asChildViewController: ligandCollectionVC,
        on: ligandListContainerView)
  }
}

extension LigandListViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    let searchText = searchController.searchBar.text?.uppercased() ?? ""
    let collection = getCollection(withSearchText: searchText)

    ligandCollectionVC.ligandsList = collection
    ligandCollectionVC.reloadData()
  }

  //----------------------------------------------------------------------------
  // MARK: - Filter search results
  //----------------------------------------------------------------------------

  /// Return a collection with elements that match the search text
  private func getCollection(
    withSearchText text: String
  ) -> LigandSectionSource.Sections {

    if text.isEmpty { return ligandCollection }

    let filteredLigandsList =
      ligandsList.filtered(isIncluded: { $0.contains(text) })

    return getReorderedCollection(from: filteredLigandsList,
                                  withSearchText: text)
  }

  /// Reorder collection to set sections with matching name in the top of the research
  private func getReorderedCollection(
    from list: LigandsAppList,
    withSearchText text: String
  ) -> LigandSectionSource.Sections {

    var collection = LigandsCollectionBuilder.build(from: list)

    let sectionStartingWithText =
      collection.firstIndex() { $0.section.title.starts(with: text) }

    if let index = sectionStartingWithText {
      let item = collection.remove(at: index)
      collection.insert(item, at: 0)
    }

    return collection
  }
}
