import UIKit

@IBDesignable
class LigandDetailView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet var contentView: UIView!
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

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }


  private func setup() {
    loadNib()
    setupView()

    contentView.frame = bounds
    addSubview(contentView)
  }


  private func setupView() {
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
