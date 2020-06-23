import UIKit

@IBDesignable
class FingerprintButtonView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private var contentView: UIView!
  @IBOutlet weak var fingerprintImageView: UIImageView!
  @IBOutlet weak var detailLabel: UILabel!
  @IBOutlet weak var blurView: UIVisualEffectView!

  /******************** Parameters ********************/

  @IBInspectable var failureColor: UIColor?

  @IBInspectable var successColor: UIColor?

  @IBInspectable var defaultColor: UIColor? = .label

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
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func setAsSuccess(message: String? = nil) {
    setup(color: successColor)
    setup(message: message)
  }

  func setAsFailure(message: String? = nil) {
    setup(color: failureColor)
    setup(message: message)
  }

  func setAsDefault(message: String? = nil) {
    setup(color: defaultColor)
    setup(message: message)
  }

  func hideFingerprintImage() {
    fingerprintImageView.isHidden = true
  }

  func showFingerprintImage() {
    fingerprintImageView.isHidden = false
  }

  /******************** Internal methods ********************/

  private func setup(color: UIColor?) {
    fingerprintImageView.tintColor = color
    detailLabel.textColor = color
  }

  private func setup(message: String?) {
    guard let message = message else {
      detailLabel.isHidden = true
      return
    }

    detailLabel.isHidden = false
    detailLabel.text = message
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
    setupBlurView()
    setupImageView()
  }

  private func setupBlurView() {
    blurView.clipsToBounds = true
  }

  private func setupImageView() {
    fingerprintImageView.image = SPAssets.fingerprint.image.alwaysTemplate
  }

}

