import UIKit

//==============================================================================
// MARK: - Auto layout
//==============================================================================

extension UIView {

  /// Add a view with given contraint type that will be activated.
  ///
  /// - Parameters:
  ///   - subview: The view to be added.
  ///   - superview: The view that will contain the view.
  ///   - constraintType: The constraint type to apply to the the subview.
  func add(subview: UIView,
           with constraintType: ConstraintType) {
    addSubview(subview)

    let constraints = constraintType.constraints(subview: subview,
                                                 superview: self)

    NSLayoutConstraint.useAndActivateConstraints(constraints: constraints)
  }

  /// Add a view with given constraints that will be activated.
  ///
  /// - Parameters:
  ///   - subview: The view to be added.
  ///   - constraints: The constraints to apply to the the subview.
  func add(subview: UIView,
           with constraints: [NSLayoutConstraint]) {
    addSubview(subview)
    NSLayoutConstraint.useAndActivateConstraints(constraints: constraints)
  }

}

//==============================================================================
// MARK: - Layer
//==============================================================================

extension UIView {

  /// Apply a shadow all around the view.
  ///
  /// - Parameters:
  ///   - color: The color of the shadow. Black by default.
  ///   - opacity: The opacity of the shadow in the range 0.0 (transparent)
  ///               to 1.0 (opaque). 1 by default.
  ///   - offset: The offset (in point) of the shadow layer. No offset by
  ///               default.
  ///   - radius: The blur radius (in points) used to render the shadow. 10 by
  ///               default.
  func applyShadow(color: CGColor? = UIColor.black.cgColor,
                   opacity: Float = 1,
                   offset: CGSize = .zero,
                   radius: CGFloat = 10) {
    layer.shadowColor = color
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
    layer.shadowRadius = radius
  }

  /// Apply a shadow effect only at the bottom of the view.
  ///
  /// - Parameters:
  ///   - color: The color of the shadow. Black by default.
  ///   - opacity: The opacity of the shadow in the range 0.0 (transparent)
  ///               to 1.0 (opaque). 1 by default.
  ///   - offset: The offset (in point) of the shadow layer. No offset by
  ///               default.
  ///   - radius: The blur radius (in points) used to render the shadow. 10 by
  ///               default.
  func applyShadowToBottom(color: CGColor? = UIColor.black.cgColor,
                           opacity: Float = 1,
                           offset: CGSize = .zero,
                           radius: CGFloat = 10) {
    applyShadow(color: color, opacity: opacity, offset: offset, radius: radius)

    // x and width make sure the shadow takes the full horizontal width of your
    // view (you might want to adjust them, for example using the
    // layer.shadowRadius value as a basis for your offsetting).
    // y and height make sure the shadow starts as low as possible and then is
    // only as big as the radius.

    let shadowRect = CGRect(x: 0,
                            y: bounds.maxY - layer.shadowRadius,
                            width: bounds.width,
                            height: layer.shadowRadius)
    self.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
  }

}

//==============================================================================
// MARK: - Keyboard
//==============================================================================

extension UIView {

  /// Enable keyboard dismiss when touching the view
  func enableKeyboardDismiss() {
    let selector = #selector(endEditing(_:))
    let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action: selector)
    self.addGestureRecognizer(tapGestureRecognizer)
    self.isUserInteractionEnabled = true
  }

  /// Disable keyboard dismiss when touching the view
  func disableKeyboardDismiss() {
    let selector = #selector(endEditing(_:))
    let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action: selector)
    self.removeGestureRecognizer(tapGestureRecognizer)
  }

}
