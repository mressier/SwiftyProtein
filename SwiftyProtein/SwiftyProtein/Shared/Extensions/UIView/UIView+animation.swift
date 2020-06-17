import Foundation
import UIKit

extension UIView {

  //----------------------------------------------------------------------------
  // MARK: - Fade
  //----------------------------------------------------------------------------

  /// View alpha fade in
  func fadeIn(duration: TimeInterval = 0.3,
              animated: Bool = true,
              completion: (() -> Void)? = nil) {
    fade(to: 1.0, animated: animated)
  }

  func fadeOut(duration: TimeInterval = 0.3,
               animated: Bool = true) {
    fade(to: 0.0, animated: animated)
  }

  func fade(to alpha: CGFloat,
            duration: TimeInterval = 0.3,
            animated: Bool = true) {
    UIView.animate(withDuration: animated ? duration : 0.0) {
      self.alpha = alpha
    }
  }
}
