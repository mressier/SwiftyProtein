import UIKit

class LigandDetailViewController: UIViewController {
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var atomNameLabel: UILabel!
  @IBOutlet weak var positionLabel: UILabel!
  @IBOutlet weak var usefullInformation1Label: UILabel!
  @IBOutlet weak var usefullInformation2Label: UILabel!
  @IBOutlet weak var usefullInformation3Label: UILabel!

  /******************** Parameter ********************/

  var atom: PDBAtomLight? {
    didSet {
      guard let atom = atom else { return setupLabelText() }
      update(with: atom)
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    setupLabelText()
  }

  private func setupLabelText() {
    symbolLabel.text = "-"
    atomNameLabel.text = "----"
    positionLabel.text = "x: --.--, y: --.--, z: --.--"
    usefullInformation1Label.text = "xx info 1"
    usefullInformation2Label.text = "xx info 2"
    usefullInformation3Label.text = "xx info 3"
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  private func update(with atom: PDBAtomLight) {
    let symbol = atom.symbol
    let position = atom.position
    let atomName = AtomsList.atomsBySymbol[symbol]?.name.capitalized

    symbolLabel.text = symbol
    atomNameLabel.text = atomName ?? symbol

    let format = String(format: "x: %.2f, y: %.2f, z: %.2f",
                        position.x,
                        position.y,
                        position.z)
    positionLabel.text = format

    usefullInformation1Label.text = "xx info 1"
    usefullInformation2Label.text = "xx info 2"
    usefullInformation3Label.text = "xx info 3"
  }
}

