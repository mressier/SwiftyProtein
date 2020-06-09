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
  @IBOutlet weak var coordinatesView: AtomCoordinatesView!
  @IBOutlet weak var usefullInformationsView: AtomDetailsInformationsView!

  /******************** Parameter ********************/

  var atom: PDBAtomLight? {
    didSet { update(with: atom) }
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
    setupInformationsLabel()
  }

  private func setupLabelText() {
    symbolLabel.text = "-"
    atomNameLabel.text = "----"
  }

  private func setupInformationsLabel() {
    usefullInformationsView.informations = [
      "xx info 1",
      "xx info 2",
      "xx info 3"
    ]
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  private func update(with atom: PDBAtomLight?) {
    let symbol = atom?.symbol ?? "-"
    let atomName = AtomsList.atomsBySymbol[symbol]?.name.capitalized

    symbolLabel.text = symbol
    atomNameLabel.text = atomName ?? symbol

    coordinatesView.coordinates = atom?.position

    usefullInformationsView.informations = [
      "xx info 1",
      "xx info 2",
      "xx info 3"
    ]
  }
}
