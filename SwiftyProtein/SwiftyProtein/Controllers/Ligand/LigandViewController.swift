import UIKit

class LigandViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var ligandSceneContainerView: UIView!
  @IBOutlet weak var ligandLoaderContainerView: UIView!
  @IBOutlet weak var shareButtonItem: UIBarButtonItem!
  @IBOutlet weak var likeButtonItem: UIBarButtonItem!

  /******************** Computed properties ********************/

  var selectedAtom: PDBAtomLight? {
    didSet { updateSelectedAtom(to: selectedAtom) }
  }

  var ligand: String?

  /******************** Configuration ********************/

  var configuration = LigandSceneConfiguration(colorMode: .cpk)

  /******************** Providers ********************/

  private let ligandProvider = LightLigandProvider()

  private let network = NetworkAccess()

  /******************** View controllers ********************/

  private lazy var ligandSceneVC: LigandSceneViewController = {
    return LigandSceneViewController(bundle: .main)
  }()

  private lazy var atomDetailVC: AtomDetailsPopUpViewController = {
    return AtomDetailsPopUpViewController(bundle: .main)
  }()

  private lazy var loaderVC: LigandLoaderViewController = {
    return LigandLoaderViewController(bundle: .main)
  }()

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    guard let ligand = ligand else { return }

    loadLigand(ligand)
  }

  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

  @IBAction func likeButtonTouched(_ sender: UIBarButtonItem) {
    guard let ligand = ligand else { return }

    ligandProvider.toggleFavorite(ligand: ligand)
    toggleLikeButton(isLiked: ligandProvider.isFavorite(ligand: ligand))
  }


  @IBAction func shareButtonTouched(_ sender: UIBarButtonItem) {
    let image = ligandSceneVC.takeSnapshot().jpegData(compressionQuality: 0.8)

    guard let ligand = ligand, let atomImage = image else {
      print("Missing ligand or image")
      return
    }
    showShareAction(for: ligand, image: atomImage)
  }

  private func showShareAction(for ligand: String,
                               image: Data) {
    let title = "Take a look at this ligand: \(ligand)"
    let vc = UIActivityViewController(activityItems: [title, image],
                                      applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem =
      navigationItem.rightBarButtonItem

    updateSelectedAtom(to: nil)
    present(vc, animated: true)
  }

  //----------------------------------------------------------------------------
  // MARK: - Load
  //----------------------------------------------------------------------------

  private func loadLigand(_ ligand: String) {
    title = ligand

    loaderVC.loadLigand(ligand)
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  private func updateSelectedAtom(to atom: PDBAtomLight?) {
    let previousAtom = atomDetailVC.atom

    if let atom = atom {
      presentAtomDetailVC(with: atom, previousAtom: previousAtom)
    } else {
      dismissAtomDetailVC(previousAtom: previousAtom)
    }

    atomDetailVC.atom = atom
  }

  //----------------------------------------------------------------------------
  // MARK: - Atom Details
  //----------------------------------------------------------------------------

  private func presentAtomDetailVC(with atom: PDBAtomLight,
                                   previousAtom: PDBAtomLight?) {
    guard previousAtom == nil else { return }

    present(atomDetailVC,
            presentationStyle: .overCurrentContext,
            shouldDisableUserInteraction: true)
  }

  private func dismissAtomDetailVC(previousAtom: PDBAtomLight?) {
    guard previousAtom != nil else { return }

    atomDetailVC.dismiss(animated: true)
  }

  private func toggleLikeButton(isLiked: Bool) {
    let asset = isLiked ? SPAssets.heartFilled : SPAssets.heartEmpty
    likeButtonItem.image = asset.image.alwaysTemplate
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupLigandProvider()
    setupLigandSceneVC()
    setupAtomDetailView()
    setupLoaderVC()
  }


  private func setupLigandProvider() {
    ligandProvider.delegate = self
  }

  private func setupLigandSceneVC() {
    ligandSceneVC.didSelectAtom = { [weak self] atom in
      self?.selectedAtom = atom
    }

    ligandSceneVC.didUnselectAtom = { [weak self] in
      self?.selectedAtom = nil
    }

    add(asChildViewController: ligandSceneVC, on: ligandSceneContainerView)
  }

  private func setupAtomDetailView() {
    atomDetailVC.modalPresentationStyle = .overCurrentContext
  }

  private func setupLoaderVC() {
    add(asChildViewController: loaderVC, on: ligandLoaderContainerView)

    loaderVC.didComplete = { [weak self] ligand in
      self?.shareButtonItem.isEnabled = true
      self?.likeButtonItem.isEnabled = true
      self?.toggleLikeButton(isLiked: ligand.isFavorite)
      self?.ligandSceneVC.ligand = ligand.centered()
      self?.ligandSceneVC.reload()
    }
  }
}

extension LigandViewController: LightLigandProviderDelegate {
  func didGetLigand(_ ligand: PDBLightLigand) {
    // Not used here
  }

  func didFailGetLigand(_ error: Error) {
    // Not used here
  }

  func didToogleLikeLigand(_ isLiked: Bool) {
    toggleLikeButton(isLiked: isLiked)
  }

}
