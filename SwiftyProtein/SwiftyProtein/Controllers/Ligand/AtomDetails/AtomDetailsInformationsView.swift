import UIKit

class AtomDetailsInformationsView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private var contentView: UIView!
  @IBOutlet weak var informationsStackView: LabelStackView!

  /******************** Parameters ********************/

  var informations: [String] = [] {
    didSet { setupInformationsStackView(informations: informations) }
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

  private func setup() {
    loadNib()
    setupView()

    contentView.frame = bounds
    addSubview(contentView)
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setupView() {
    setupInformationsStackView(informations: informations)
  }

  private func setupInformationsStackView(informations: [String]) {
    informationsStackView.texts = informations
    informationsStackView.textFont = .systemFont(ofSize: 12.0)
    informationsStackView.textColor = .secondaryLabel
    informationsStackView.textAlignment = .right
  }

}

