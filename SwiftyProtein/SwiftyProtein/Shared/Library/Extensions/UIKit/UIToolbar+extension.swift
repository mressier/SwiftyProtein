import UIKit

extension UIToolbar {
  static func getDefaultToolBar(target: UIView?,
                                validAction: Selector? = nil,
                                cancelAction: Selector? = nil) -> UIToolbar {
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.tintColor = .melomindBlue
    toolBar.backgroundColor = .white
    toolBar.sizeToFit()

    toolBar.setItems([getDoneButton(action: validAction),
                      getFakeButton(), // space between buttons
                      getCancelButton(action: cancelAction)],
                     animated: false)
    toolBar.isUserInteractionEnabled = true
    return toolBar
  }

  //----------------------------------------------------------------------------
  // MARK: - Create bar button items
  //----------------------------------------------------------------------------

  private static func getFakeButton() -> UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                           target: nil,
                           action: nil)
  }

  private static func getDoneButton(action: Selector?) -> UIBarButtonItem {
    guard let selector = action else { return getFakeButton() }

    let button = UIBarButtonItem(title: "Done",
                                 style: .done,
                                 target: target,
                                 action: selector)

    button.tintColor = .melomindBlue
    return button
  }

  private static func getCancelButton(action: Selector?) -> UIBarButtonItem {
    guard let selector = action else { return getFakeButton() }

    let button = UIBarButtonItem(
      image: MBTAsset.pictoClose.image.alwaysTemplate,
      style: .plain,
      target: target,
      action: selector
    )

    button.tintColor = .melomindBlue
    return button
  }
}
