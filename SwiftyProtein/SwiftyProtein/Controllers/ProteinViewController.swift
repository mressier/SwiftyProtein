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
    let proteinSceneVC = ProteinSceneViewController(bundle: .main)

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
    selectedAtomNameLabel.text = ""
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------
  private func updateSelectedAtom(to atom: Atom?) {
    selectedAtomNameLabel.text = atom?.name ?? ""
    selectedAtomNameLabel.textColor = atom?.color
  }
}
