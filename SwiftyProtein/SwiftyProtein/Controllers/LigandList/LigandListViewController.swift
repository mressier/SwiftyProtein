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
      searchController.ligandsList = ligandsList
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
    searchController.ligandsList = ligandsList
  }

  private func setupLigandCollectionVC() {
    ligandsList = LigandsAppList(ligands: FileReader.readLigandFile(),
                                  favorites: ["A", "B1"])

    ligandCollectionVC.ligandsList = ligandCollection

    ligandCollectionVC.didSelectLigand = { [weak self] ligand in
      self?.performSegue(withIdentifier: "segueToLigandView", sender: ligand)
    }

    add(asChildViewController: ligandCollectionVC,
        on: ligandListContainerView)
  }

  //----------------------------------------------------------------------------
  // MARK: - Navigation
  //----------------------------------------------------------------------------

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destination = segue.destination as? LigandViewController,
      let ligand = sender as? LigandCollection.Ligand else { return }
    destination.ligand = ligand.name
  }

  @IBAction func unwindToListViewController(_ unwindSegue: UIStoryboardSegue) {
//    let sourceViewController = unwindSegue.source
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
