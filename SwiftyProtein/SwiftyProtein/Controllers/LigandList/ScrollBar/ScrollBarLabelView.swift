import UIKit

@IBDesignable
class ScrollBarLabelView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private var contentView: UIView!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var textLabel: UILabel!

  /******************** Parameters ********************/

  var text: String? {
    didSet {
      if let text = text, !text.isEmpty {
        textLabel.text = text
        containerView.isHidden = false
      } else {
        containerView.isHidden = true
      }
    }
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
    setupLabel()
    setupContainerView()
  }

  private func setupLabel() {
    textLabel.textColor = .white
    textLabel.font = UIFont.systemFont(ofSize: 10.0)
  }

  private func setupContainerView() {
    containerView.backgroundColor = .swiftyBlue

    containerView.borderWidth = 1.0
    containerView.cornerRadius = 5.0
    containerView.borderColor = .swiftyDarkBlue
  }

}

