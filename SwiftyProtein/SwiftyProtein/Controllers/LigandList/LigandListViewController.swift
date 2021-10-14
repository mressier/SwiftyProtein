import UIKit

class LigandListViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var ligandListContainerView: UIView!
  @IBOutlet weak var alertLabel: LineAlertView!
  @IBOutlet weak var alertLabelHeightConstraint: NSLayoutConstraint!

  /******************** Parameters ********************/

  var ligandsList = LigandsAppList(ligands: [], favorites: [])

  /******************** View Controllers ********************/

  private let searchController =
    LigandSearchController(searchResultsController: nil)

  private let ligandCollectionVC =
    LigandCollectionViewController(bundle: .main)

  /******************** Internet ********************/

  lazy var networkAccess: NetworkAccessor = {
    return NetworkAccess(delegate: self)
  }()

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setupMessageView()
    updateLigandList()
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  private func updateLigandList() {
    ligandsList = LigandsAppList(ligands: FileReader.readLigandFile(),
                                 favorites: LocalStorage.shared.favorites)

    searchController.ligandsList = ligandsList
    ligandCollectionVC.ligandsList =
      LigandsCollectionBuilder.build(from: ligandsList)
    ligandCollectionVC.reloadData()
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupView()
    setupMessageView()
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
    ligandCollectionVC.didSelectLigand = { [weak self] ligand in
      self?.performSegue(withIdentifier: "segueToLigandView", sender: ligand)
    }

    add(asChildViewController: ligandCollectionVC,
        on: ligandListContainerView)
  }

  private func setupMessageView() {
    alertLabel.message = "No internet connection"
    alertLabel.alertType = .error
    setNetworkErrorVisible(!networkAccess.hasNetworkAccess)
  }

  private func setNetworkErrorVisible(_ isVisible: Bool) {
    isVisible ? alertLabel.show() : alertLabel.hide()
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
  }
}

//==============================================================================
// MARK: - UISearchResultsUpdating
//==============================================================================

extension LigandListViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let searchController =
      searchController as? LigandSearchController else { return }

    let searchText = searchController.searchBar.text?.uppercased() ?? ""
    let ligandsList = searchController.getLigandsList(withSearchText: searchText)

    updateSearchResults(with: ligandsList, searchText: searchText)
  }

  /// Update ligand collection table view with the ligands list filtered with the given search text
  private func updateSearchResults(with ligandsList: LigandsAppList,
                                   searchText: String) {
    let collection = LigandsCollectionBuilder.build(from: ligandsList)
    var list = collection

    if shouldDisplaySearchSection(forSearchText: searchText, on: ligandsList) {
      let searchSection = (section: LigandCollection.Header(title: "🌐", image: nil),
                            content: [LigandCollection.Ligand(name: searchText, isFavorite: false)])

      list.insert(searchSection, at: 0)
    }

    ligandCollectionVC.ligandsList = list
    ligandCollectionVC.reloadData()
  }

  /// Research section should be displayed when the research is in progress (= something is typed)
  /// and there is no results on the ligands list that match exactly the result
  private func shouldDisplaySearchSection(
    forSearchText searchText: String,
    on ligandsList: LigandsAppList
  ) -> Bool {
    return !searchText.isEmpty && !ligandsList.contains(ligand: searchText)
  }
}

//==============================================================================
// MARK: - NetworkAccessDelegate
//==============================================================================

extension LigandListViewController: NetworkAccessDelegate {
  func networkAccessDidChanged(_ hasNetworkAccess: Bool) {
    setNetworkErrorVisible(!hasNetworkAccess)

    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
  }
}
