import UIKit

extension UIScrollView {

  /// Return content offset as a percent between 0 and 1 of the total scroll view
  var contentOffsetPercent: CGSize {
    let height = contentSize.height - visibleSize.height
    let width = contentSize.width - visibleSize.width

    let percentHeight = height != 0 ? CGFloat(contentOffset.y) / height : 0.0
    let percentWidth = width != 0 ? CGFloat(contentOffset.x) / width : 0.0
    return CGSize(width: percentWidth, height: percentHeight)
  }

}
