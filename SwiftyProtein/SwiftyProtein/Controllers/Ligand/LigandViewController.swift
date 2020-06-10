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

  private var isLoading: Bool = false

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

    guard let ligand = ligand else { return }
    loadLigand(name: ligand)
  }

  //----------------------------------------------------------------------------
  // MARK: - Load
  //----------------------------------------------------------------------------

  private func loadLigand(name: String) {
    self.title = name

    toggleLoagingView(isLoading: true)
    LightLigandProvider.get(ligand: name) { [weak self] result in
      switch result {
      case .success(let ligand):
        self?.ligandSceneVC.atoms = ligand.atoms
        self?.ligandSceneVC.reload() { [weak self] in self?.toggleLoagingView(isLoading: false) }
      default:
        // change message depending on error
        self?.toggleMessageView(showMessage: true)
        self?.toggleLoagingView(isLoading: false)
      }
    }
  }

  private func toggleLoagingView(isLoading: Bool, animated: Bool = true) {
    self.isLoading = isLoading

    UIView.animate(withDuration: animated ? 0.5 : 0.0) {
      self.loadingView?.alpha = isLoading ? 1.0 : 0.0
    }
  }

  private func toggleMessageView(showMessage: Bool, animated: Bool = true) {
    UIView.animate(withDuration: animated ? 0.5 : 0.0) {
      self.messageView?.alpha = showMessage ? 1.0 : 0.0
    }
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

}
