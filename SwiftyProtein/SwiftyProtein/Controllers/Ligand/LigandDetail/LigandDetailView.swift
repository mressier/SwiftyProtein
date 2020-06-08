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
  @IBOutlet weak var positionsLabelsStackView: LabelStackView!
  @IBOutlet weak var usefullInformationLabelsStackView: LabelStackView!

  /******************** Parameter ********************/

  var atom: PDBAtomLight? {
    didSet {
      guard let atom = atom else { return setupView() }
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
    setupPositionsLabels()
    setupInformationsLabel()
  }

  private func setupLabelText() {
    symbolLabel.text = "-"
    atomNameLabel.text = "----"
  }

  private func setupInformationsLabel() {
    usefullInformationLabelsStackView.texts = [
      "xx info 1",
      "xx info 2",
      "xx info 3"
    ]
    usefullInformationLabelsStackView.textFont = .systemFont(ofSize: 14.0)
    usefullInformationLabelsStackView.textColor = .secondaryLabel
  }

  private func setupPositionsLabels() {
    positionsLabelsStackView.texts = ["x: --.--", "y: --.--", "z: --.--"]
    positionsLabelsStackView.textFont = .systemFont(ofSize: 14.0)
    positionsLabelsStackView.textColor = .label
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

    positionsLabelsStackView.texts = [String(format: "x: %.2f", position.x),
                                 String(format: "y: %.2f", position.y),
                                 String(format: "z: %.2f", position.z)]

    usefullInformationLabelsStackView.texts = [
      "xx info 1",
      "xx info 2",
      "xx info 3"
    ]
  }
}
