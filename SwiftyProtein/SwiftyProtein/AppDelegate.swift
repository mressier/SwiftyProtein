//
//  AppDelegate.swift
//  SwiftyProtein
//
//  Created by Mathilde Ressier on 15/02/2020.
//  Copyright © 2020 Mathilde Ressier. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    guard let presentedVC = presentedViewController else { return }

    if shouldPresentLoginVC(on: presentedVC) {
      showLoginVC(on: presentedVC)
    }
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  //----------------------------------------------------------------------------
  // MARK: - Current VC
  //----------------------------------------------------------------------------

  var presentedViewController: UIViewController? {
    let rootVC = self.window?.rootViewController

    return rootVC?.presentedViewController
  }

  //----------------------------------------------------------------------------
  // MARK: - LoginVC
  //----------------------------------------------------------------------------

  private func shouldPresentLoginVC(on vc: UIViewController?) -> Bool {
    let isWelcomeVC = vc is WelcomeViewController
    return !isWelcomeVC
  }

  private func showLoginVC(on vc: UIViewController?) {
    let loginVC = LoginViewController(bundle: .main)
    loginVC.modalPresentationStyle = .fullScreen

    loginVC.didComplete = { loginVC.dismiss(animated: true) }

    vc?.present(loginVC, animated: true) {
      loginVC.startAuthentication()
    }
  }


}

