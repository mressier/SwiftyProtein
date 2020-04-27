import UIKit

class LigandListViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var ligandListContainerView: UIView!

  /******************** Callbacks ********************/

  /******************** Parameters ********************/

  var ligandsList = LigandsAppList(ligands: ["A", "AB", "B", "B1", "C", "1C", "D", "D3E", "E", "F"],
                                   favorites: ["A", "B1"])

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

    ligandCollectionVC.ligandsList =
      LigandsCollectionBuilder.build(from: ligandsList)

    add(asChildViewController: ligandCollectionVC,
        on: ligandListContainerView)
  }
}

extension LigandListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
  }
}
