import UIKit

@IBDesignable class PaddedLabel: UILabel, Padded {

  //----------------------------------------------------------------------------
  // MARK: - Padded Label
  //----------------------------------------------------------------------------

  @IBInspectable var globalInset: CGFloat = 0.0 {
    didSet {
      topInset = globalInset
      bottomInset = globalInset
      leftInset = globalInset
      rightInset = globalInset
    }
  }

  @IBInspectable var topInset: CGFloat = 0.0
  @IBInspectable var bottomInset: CGFloat = 0.0
  @IBInspectable var leftInset: CGFloat = 0.0
  @IBInspectable var rightInset: CGFloat = 0.0

  //----------------------------------------------------------------------------
  // MARK: - Override
  //----------------------------------------------------------------------------

  override func drawText(in rect: CGRect) {
    let insets = edgeInsets
    super.drawText(in: rect.inset(by: insets))
  }

  override var intrinsicContentSize: CGSize {
    let size = super.intrinsicContentSize
    return CGSize(width: size.width + leftInset + rightInset,
                  height: size.height + topInset + bottomInset)
  }

  override var bounds: CGRect {
    didSet {
      // ensures this works within stack views if multi-line
      preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
    }
  }
}
