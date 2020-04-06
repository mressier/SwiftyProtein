//
//  UINavigation+Extension.swift
//  Melomind.iOS-V2
//
//  Created by facileit on 23/01/2018.
//  Copyright © 2018 MyBrainTech. All rights reserved.
//

import UIKit

extension UINavigationController {

  func customizeNavigationBar() {

    // Sets the navigationbar background color
    self.navigationBar.isTranslucent = true
    //UIBarButtonItem.appearance().tintColor = .white

    self.navigationBar.tintColor = .white
    // Those 2 lines hide the navigationbar 1px shadow line
    self.navigationBar.shadowImage = UIImage()
    self.navigationBar.setBackgroundImage(UIImage(),
                                          for: .any,
                                          barMetrics: .default)

    self.navigationBar.tintAdjustmentMode = .normal

    self.setNeedsStatusBarAppearanceUpdate()
  }

  func pushViewControllerWithSound(_ viewControllerToPush: UIViewController,
                                   animated flag: Bool) {
    AudioMixer.shared.effect.play(.present)
    pushViewController(viewControllerToPush, animated: flag)
  }

  func popViewControllerWithSound(_ animated: Bool) {
    AudioMixer.shared.effect.play(.dismiss)
    popViewController(animated: animated)
  }
}
