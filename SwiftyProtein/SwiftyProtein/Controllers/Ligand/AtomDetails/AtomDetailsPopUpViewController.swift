import UIKit

class AtomDetailsPopUpViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private weak var atomDetailsView: AtomDetailsView!
  @IBOutlet private weak var effectView: UIVisualEffectView!

  /******************** Properties ********************/

  var atom: PDBAtomLight? {
    didSet { setupAtomDetailsView(atom: atom) }
  }

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    atomDetailsView?.atom = atom
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupAtomDetailsView()
    setupEffectViews()
  }

  private func setupAtomDetailsView() {
    setupAtomDetailsView(atom: atom)
    atomDetailsView?.cornerRadius = 5.0
    atomDetailsView?.borderColor = .tertiaryLabel
    atomDetailsView?.borderWidth = 0.5
  }

  private func setupAtomDetailsView(atom: PDBAtomLight?) {
    atomDetailsView?.atom = atom
  }

  private func setupEffectViews() {
    effectView.cornerRadius = 5.0
    effectView.clipsToBounds = true
  }
}
