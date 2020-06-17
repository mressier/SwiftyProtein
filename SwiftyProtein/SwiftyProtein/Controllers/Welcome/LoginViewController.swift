import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  private func setup() {
    setupTouchIDAuthentication()
  }

  private func setupTouchIDAuthentication() {
    let context = LAContext()
    var error: NSError?

    let policy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
    let reason = "Access to very secret ligand informations"

    context.localizedCancelTitle = "Cancel"
    guard context.canEvaluatePolicy(policy, error: &error) else {
      print(error)
      return
    }

    context.evaluatePolicy(policy, localizedReason: reason) { success, error in
      if success {
        print("yeay")
      } else {
        print(error?.localizedDescription ?? "Fail to auth")
      }
    }
  }

}
