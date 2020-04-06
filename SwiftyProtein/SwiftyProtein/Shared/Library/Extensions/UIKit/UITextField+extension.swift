import UIKit

extension UITextField {

  //----------------------------------------------------------------------------
  // MARK: - UI
  //----------------------------------------------------------------------------

  func setPlaceholder(_ placeholder: String?, color: UIColor?) {
    guard let placeholder = placeholder,
      let textColor = color ?? tintColor else { return }

    let attributes: [NSAttributedString.Key: Any] =
      [.foregroundColor: textColor]

    self.attributedPlaceholder =
      NSAttributedString(string: placeholder, attributes: attributes)
  }
}
