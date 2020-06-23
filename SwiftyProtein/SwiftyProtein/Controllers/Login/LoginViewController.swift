import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var titleImageView: UIImageView!
  @IBOutlet weak var buttonContainerView: UIView!

  /******************** VC ********************/

  private lazy var authButtonVC: AuthButtonViewController = {
    return AuthButtonViewController(bundle: .main)
  }()

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    authButtonVC.startAuthentication()
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupAuthButton()
  }

  private func setupAuthButton() {
    add(asChildViewController: authButtonVC, on: buttonContainerView)

    authButtonVC.didComplete = { [weak self] in
      self?.performSegue(withIdentifier: "loginSegue", sender: nil)
    }

  }

}
