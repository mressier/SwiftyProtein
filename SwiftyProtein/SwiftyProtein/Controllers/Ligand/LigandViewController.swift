import UIKit

class LigandViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var ligandSceneContainerView: UIView!
  @IBOutlet weak var loadingView: LoadingView!

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

    setLoading(true)
    LightLigandProvider.get(ligand: name) { [weak self] result in
      switch result {
      case .success(let ligand):
        self?.ligandSceneVC.atoms = ligand.atoms
        self?.ligandSceneVC.reload() { [weak self] in self?.setLoading(false) }
      default:
        print("hoho")
        self?.setLoading(false)
      }
    }
  }

  private func setLoading(_ isLoading: Bool) {
    self.isLoading = isLoading

    UIView.animate(withDuration: 0.5) {
      self.loadingView?.alpha = isLoading ? 1.0 : 0.0
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  private func updateSelectedAtom(to atom: PDBAtomLight?) {
    updateSelectedAtomNameLabel(with: atom)
  }

  private func updateSelectedAtomNameLabel(with atom: PDBAtomLight?) {
    print(atom?.symbol)
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupLigandSceneVC()
    setupAtomLabel()
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

  private func setupAtomLabel() {
  }

  private func setupLoadingView() {
    loadingView.isUserInteractionEnabled = false
  }

}
