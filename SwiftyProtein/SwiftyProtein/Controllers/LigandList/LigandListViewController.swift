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
    LigandSearchController(searchResultsController: nil)

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
    guard let searchController =
      searchController as? LigandSearchController else { return }

    let searchText = searchController.searchBar.text?.uppercased() ?? ""
    let ligandsList =
      searchController.getLigandsList(withSearchText: searchText)
    let collection =
      searchController.getReorderedCollection(from: ligandsList,
                                              withSearchText: searchText)

    ligandCollectionVC.ligandsList = collection
    ligandCollectionVC.reloadData()
  }
}
