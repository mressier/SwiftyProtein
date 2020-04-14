import UIKit

extension NSLayoutConstraint {

  /// Active the given constraints and set the related view autoresizing mask to
  /// false.
  ///
  /// - Parameter constraints: The constraints to activate.
  class func useAndActivateConstraints(constraints: [NSLayoutConstraint]) {
    for constraint in constraints {
      if let view = constraint.firstItem as? UIView {
        view.translatesAutoresizingMaskIntoConstraints = false
      }
    }
    activate(constraints)
  }

}
