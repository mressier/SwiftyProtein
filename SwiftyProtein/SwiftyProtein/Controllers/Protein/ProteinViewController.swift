import UIKit

class ProteinViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var proteinSceneContainerView: UIView!
  @IBOutlet weak var selectedAtomNameLabel: UILabel!

  /******************** Computed properties ********************/

  var selectedAtom: PDBAtomLight? {
    didSet { updateSelectedAtom(to: selectedAtom) }
  }

  /******************** Configuration ********************/

  var configuration = ProteinSceneConfiguration(colorMode: .cpk)

  /******************** View controllers ********************/

  private lazy var proteinSceneVC: ProteinSceneViewController = {
    return ProteinSceneViewController(bundle: .main)
  }()

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    loadLigand()
  }

  private func setup() {
    setupProteinSceneVC()
    setupAtomLabel()
  }

  private func setupProteinSceneVC() {
    proteinSceneVC.didSelectAtom = { [weak self] atom in
      self?.selectedAtom = atom
    }

    proteinSceneVC.didUnselectAtom = { [weak self] in
      self?.selectedAtom = nil
    }

    add(asChildViewController: proteinSceneVC, on: proteinSceneContainerView)
  }

  private func setupAtomLabel() {
    selectedAtomNameLabel.text = " "
  }

  private func loadLigand() {
    let ligandName = "10R"

    self.title = ligandName

    LightLigandProvider.get(ligand: ligandName) { [weak self] result in
      switch result {
      case .success(let ligand):
        self?.proteinSceneVC.atoms = ligand.atoms
        self?.proteinSceneVC.reload()
      default: print("hoho")
      }
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------
  private func updateSelectedAtom(to atom: PDBAtomLight?) {
    updateSelectedAtomNameLabel(with: atom)
  }

  private func updateSelectedAtomNameLabel(with atom: PDBAtomLight?) {
    guard let atom = atom else {
      selectedAtomNameLabel.text = " "
      return
    }

    let strokeTextAttributes: [NSAttributedString.Key : Any] = [
      NSAttributedString.Key.strokeColor : UIColor.darkGray,
      NSAttributedString.Key.strokeWidth: -4,
      NSAttributedString.Key.foregroundColor: configuration.getColor(for: atom)
    ]

    selectedAtomNameLabel.textColor = configuration.getColor(for: atom)
    selectedAtomNameLabel.attributedText =
      NSMutableAttributedString(string: atom.symbol,
                                attributes: strokeTextAttributes)
  }
}
