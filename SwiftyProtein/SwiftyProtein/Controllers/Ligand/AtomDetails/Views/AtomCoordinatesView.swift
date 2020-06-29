import UIKit
import SceneKit

class AtomCoordinatesView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private var contentView: UIView!
  @IBOutlet weak var labelsStackView: LabelStackView!

  /******************** Parameters ********************/

  var coordinates: SCNVector3? {
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
    setupLabels()
    setupLabelTexts(position: coordinates)
  }

  private func setupLabels() {
    labelsStackView.textFont = .systemFont(ofSize: 11.0)
    labelsStackView.lineBreakMode = .byWordWrapping
    labelsStackView.numberOfLines = 1
  }

  private func setupLabelTexts(position: SCNVector3?) {
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

