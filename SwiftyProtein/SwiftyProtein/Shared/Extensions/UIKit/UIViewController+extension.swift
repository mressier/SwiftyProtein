//
//  UIViewController+extension.swift
//  Melomind
//
//  Created by Mathilde Ressier on 15/07/2019.
//  Copyright © 2019 MyBrainTech. All rights reserved.
//

import UIKit

//==============================================================================
// MARK: - Bundle
//==============================================================================

extension UIViewController: Reusable {

  convenience init(bundle: Bundle) {
    let nibName = Self.reuseIdentifier
    self.init(nibName: nibName, bundle: Bundle.main)
  }

}

//==============================================================================
// MARK: - Container
//==============================================================================

extension UIViewController {

  func add(asChildViewController viewController: UIViewController,
           on view: UIView) {
    // Add Child View Controller
    addChild(viewController)

    // Add Child View as Subview
    view.add(subview: viewController.view, with: .edge)

    // Notify Child View Controller
    viewController.didMove(toParent: self)
  }

  func remove(asChildViewController viewController: UIViewController) {
    // Notify Child View Controller
    viewController.willMove(toParent: self)

    // Remove Child View From Superview
    viewController.view.removeFromSuperview()

    // Notify Child View Controller
    viewController.removeFromParent()
  }

}

//==============================================================================
// MARK: - Settings
//==============================================================================

extension UIViewController {

  /// Open device settings
  func openSettings(path: String = "App-Prefs:root:General") {
    let settingUrl = URL(string: path)
    guard let url = settingUrl, UIApplication.shared.canOpenURL(url) else {
        return
    }
    openURL(url)
  }

  func openAppSettings() {
    openSettings(path: UIApplication.openSettingsURLString)
  }

  func openURL(_ url: URL, completion: ((Bool) -> Void)? = nil) {
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(url,
                                options: [:],
                                completionHandler: completion)
    } else {
      let isOpened = UIApplication.shared.openURL(url)
      completion?(isOpened)
    }
  }

}

//==============================================================================
// MARK: - Update
//==============================================================================

extension UIViewController {

  func openAppStoreApplication(withId id: String,
                               completion: ((Bool) -> Void)? = nil) {
    let appStoreApplicationUrl = "itms-apps://itunes.apple.com/app/bars/id\(id)"
    let appStoreWebsiteUrl =
    "https://itunes.apple.com/us/app/apple-store/id\(id)"

    if let url = URL(string: appStoreApplicationUrl),
      UIApplication.shared.canOpenURL(url) {
      openURL(url) { isOpened in completion?(isOpened) }
    } else if let url = URL(string: appStoreWebsiteUrl),
      UIApplication.shared.canOpenURL(url) {
      openURL(url) { isOpened in completion?(isOpened) }
    } else {
      completion?(false)
    }
  }

}

//==============================================================================
// MARK: - Presentation
//==============================================================================

extension UIViewController {

  /// Present a view controller using the legacy style (prior to iOS 13).
  /// - Parameter viewControllerToPresent: The view controller to display over
  /// the current view controller’s content.
  /// - Parameter animated: Pass true to animate the presentation; otherwise,
  /// pass false.
  /// - Parameter presentationStyle: The presentation style for modally
  /// presented view controllers.
  /// - Parameter completion: The block to execute after the presentation
  /// finishes. This block has no return value and takes no parameters. You may
  /// specify nil for this parameter.
  func presentWithLegacyModalStyle(
    _ viewControllerToPresent: UIViewController,
    animated: Bool = true,
    completion: (() -> Void)? = nil) {
    present(viewControllerToPresent,
            animated: animated,
            presentationStyle: .fullScreen,
            completion: completion)
  }

  func present(_ viewControllerToPresent: UIViewController,
               animated: Bool = true,
               presentationStyle: UIModalPresentationStyle,
               shouldDisableUserInteraction: Bool = false,
               completion: (() -> Void)? = nil) {
    if #available(iOS 13.0, *) {
      viewControllerToPresent.modalPresentationStyle = presentationStyle
      viewControllerToPresent.isModalInPresentation = true
    }

    present(viewControllerToPresent, animated: animated) {
      if shouldDisableUserInteraction {
        let superview = viewControllerToPresent.view.superview
        superview?.isUserInteractionEnabled = false
      }
      completion?()
    }
  }

  /// View controller is the one presented and visible on the screen
  var isViewControllerPresented: Bool {
    return viewIfLoaded?.window != nil
  }
  
}

//==============================================================================
// MARK: - Keyboard Dismissable
//==============================================================================

extension UIViewController {

  /// Enable keyboard dismiss when touching the view controller's view
  func enableKeyboardDismiss() {
    view.enableKeyboardDismiss()
  }

  func disableKeyboardDismiss() {
    view.disableKeyboardDismiss()
  }

}
