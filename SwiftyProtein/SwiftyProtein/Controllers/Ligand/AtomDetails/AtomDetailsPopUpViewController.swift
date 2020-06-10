import UIKit

class AtomDetailsPopUpViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var atomDetailsView: AtomDetailsView!

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
    setupAtomDetailsView(atom: atom)
  }

  private func setupAtomDetailsView(atom: PDBAtomLight?) {
    atomDetailsView?.atom = atom
  }
}
