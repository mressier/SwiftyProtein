import UIKit

extension UIAccessibilityIdentification where Self: NSObject {

  func setUITestingElement(withIdentifier identifier: String) {
    isAccessibilityElement = true
    accessibilityIdentifier = identifier
  }

}
