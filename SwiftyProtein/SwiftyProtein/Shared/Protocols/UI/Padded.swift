import UIKit

protocol Padded {
  var topInset: CGFloat { get set }
  var bottomInset: CGFloat { get set }
  var leftInset: CGFloat { get set }
  var rightInset: CGFloat { get set }
}

extension Padded {
  var edgeInsets: UIEdgeInsets {
    return UIEdgeInsets(top: topInset,
                        left: leftInset,
                        bottom: bottomInset,
                        right: rightInset)
  }
}
