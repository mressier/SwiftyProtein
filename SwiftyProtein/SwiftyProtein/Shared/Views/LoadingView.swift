import UIKit
import SwiftyGif

class LoadingView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var imageContainerView: UIView!
  @IBOutlet weak var loadingLabel: UILabel!

  /******************** Parameters ********************/

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
    setupGifView()
    setupLabel()
  }

  private func setupLabel() {
    loadingLabel.textColor = .secondaryLabel
  }

  private func setupGifView() {
    guard let gif =
      try? UIImage(gifData: SPAssets.loadingGif.data.data) else { return }

    let imageView = UIImageView(gifImage: gif, loopCount: -1)
    imageContainerView.add(subview: imageView, with: .edge)
  }
}

