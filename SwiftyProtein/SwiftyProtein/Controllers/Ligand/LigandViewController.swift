import UIKit

class LigandViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var ligandSceneContainerView: UIView!
  @IBOutlet weak var loadingView: LoadingView!
  @IBOutlet weak var messageView: MessageView!

  /******************** Computed properties ********************/

  var selectedAtom: PDBAtomLight? {
    didSet { updateSelectedAtom(to: selectedAtom) }
  }

  var ligand: String?

  /******************** Configuration ********************/

  var configuration = LigandSceneConfiguration(colorMode: .cpk)

  private let provider = LightLigandProvider()

  /******************** View controllers ********************/

  private lazy var ligandSceneVC: LigandSceneViewController = {
    return LigandSceneViewController(bundle: .main)
  }()

  private lazy var atomDetailVC: AtomDetailsPopUpViewController = {
    return AtomDetailsPopUpViewController(bundle: .main)
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
    loadLigand(ligand)
  }

  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

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
    present(vc, animated: true)
  }

  //----------------------------------------------------------------------------
  // MARK: - Load
  //----------------------------------------------------------------------------

  private func loadLigand(_ ligand: String?) {
    guard let ligand = ligand else { return }

    title = ligand
    provider.get(ligand: ligand)
  }

  //----------------------------------------------------------------------------
  // MARK: - Toggle views
  //----------------------------------------------------------------------------

  private func toggleMessageView(showMessage: Bool, animated: Bool = true) {
    showMessage ? messageView.fadeIn(animated: animated)
      : messageView.fadeOut(animated: animated)
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

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupLigandSceneVC()
    setupAtomDetailView()
    setupLoadingView()
    setupMessageView()
    setupProvider()
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

  private func setupLoadingView() {
    loadingView.isUserInteractionEnabled = false
  }

  private func setupMessageView() {
    messageView.isUserInteractionEnabled = false
    toggleMessageView(showMessage: false, animated: false)
  }

  private func setupProvider() {
    provider.view = self
    provider.delegate = self
  }

}

//==============================================================================
// MARK: - LightLigandProviderDelegate
//==============================================================================

extension LigandViewController: LightLigandProviderDelegate {
  func didGetLigand(_ ligand: PDBLightLigand) {
    ligandSceneVC.atoms = ligand.atoms
    ligandSceneVC.reload()
  }

  func didFailGetLigand(_ error: Error) {
    print(error)
    toggleMessageView(showMessage: true)
  }
}

//==============================================================================
// MARK: - LightLigandProviderView
//==============================================================================

extension LigandViewController: LightLigandProviderView {
  func setIsLoading(_ isLoading: Bool) {
    isLoading ? loadingView.fadeIn() : loadingView.fadeOut()
  }
}
