import UIKit

class WelcomeViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  private lazy var loginVC: LoginViewController = {
    return LoginViewController(bundle: .main)
  }()

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    loginVC.startAuthentication()
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupLoginVC()
  }

  private func setupLoginVC() {
    loginVC.didComplete = { [weak self] in
      self?.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    add(asChildViewController: loginVC, on: view)
  }
}
