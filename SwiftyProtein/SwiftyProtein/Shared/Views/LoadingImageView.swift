import UIKit
import SwiftyGif

@IBDesignable
class LoadingImageView: UIView {

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
    setupGifView()
  }

  private func setupGifView() {
    guard let gif =
      try? UIImage(gifData: SPAssets.loadingGif.data.data) else { return }

    let imageView = UIImageView(gifImage: gif, loopCount: -1)
    add(subview: imageView, with: .edge)
  }
}
