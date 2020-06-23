import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var titleImageView: UIImageView!
  @IBOutlet weak var buttonContainerView: UIView!

  /******************** VC ********************/

  private lazy var authButtonVC: FingerprintViewController = {
    return FingerprintViewController(bundle: .main)
  }()

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
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
