import UIKit
import SwiftyGif

@IBDesignable
class LoadingView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var loadingLabel: UILabel!

  /******************** Parameters ********************/

  @IBInspectable var loadingText: String? {
    get { return loadingLabel.text }
    set { loadingLabel.text = newValue }
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

  private func setupView() {}
}

