import UIKit

class LigandListViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  /******************** Callbacks ********************/

  /******************** Parameters ********************/

  var ligands = ["A", "B", "C"] {
    didSet {
      // reload data
    }
  }

  /******************** View Controllers ********************/

  let searchController = UISearchController(searchResultsController: nil)

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
  }

  private func setupLigandCollectionVC() {
    let ligandCollectionVC = LigandCollectionViewController(bundle: .main)

    ligandCollectionVC.ligands = ligands

    add(asChildViewController: ligandCollectionVC, on: view)
  }
}

extension LigandListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
  }
}
