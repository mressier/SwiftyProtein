import UIKit

@IBDesignable
class MessageView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var messageImageView: UIImageView!
  @IBOutlet weak var messageLabel: UILabel!

  /******************** Parameters ********************/

  @IBInspectable
  var messageText: String? {
    didSet { messageLabel.text = messageText }
  }

  @IBInspectable
  var messageImage: UIImage? {
    didSet { messageImageView.image = messageImage }
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

  private func setupView() {
    setupMessageLabel()
    setupMessageImageView()
  }

  private func setupMessageLabel() {
    messageLabel.textColor = .secondaryLabel
    messageLabel.text = messageText
  }

  private func setupMessageImageView() {
    messageImageView.tintColor = .secondaryLabel
  }

}

