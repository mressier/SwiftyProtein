import UIKit

class ProteinViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var proteinSceneContainerView: UIView!
  @IBOutlet weak var selectedAtomNameLabel: UILabel!

  /******************** Computed properties ********************/

  var selectedAtom: Atom? {
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

    proteinSceneVC.atoms = AtomBuilder.build()

    add(asChildViewController: proteinSceneVC, on: proteinSceneContainerView)
  }

  private func setupAtomLabel() {
    selectedAtomNameLabel.text = " "
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------
  private func updateSelectedAtom(to atom: Atom?) {
    print(atom?.symbol)
    updateSelectedAtomNameLabel(with: atom)
  }

  private func updateSelectedAtomNameLabel(with atom: Atom?) {
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
