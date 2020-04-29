import UIKit

extension UIImage {

  /// Return the image in rendering mode "always template"
  var alwaysTemplate: UIImage {
    return self.withRenderingMode(.alwaysTemplate)
  }

}
