import UIKit

class AtomCoordinatesView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private var contentView: UIView!
  @IBOutlet weak var labelsStackView: LabelStackView!

  /******************** Parameters ********************/

  var coordinates: PDBAtomPosition? {
    didSet { setupLabelTexts(position: coordinates) }
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    loadNib()
    setupView()

    contentView.frame = bounds
    addSubview(contentView)
  }

  private func setupView() {
    setupLabelTexts(position: coordinates)
  }

  private func setupLabelTexts(position: PDBAtomPosition?) {
    if let position = position {
      labelsStackView.texts = [
        String(format: "x: %.2f", position.x),
        String(format: "y: %.2f", position.y),
        String(format: "z: %.2f", position.z)
      ]
    } else {
      labelsStackView.texts = [
        String(format: "x: --.--"),
        String(format: "y: --.--"),
        String(format: "z: --.--")
      ]
    }
  }
}

