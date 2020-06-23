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

  /******************** Callback ********************/

  var didComplete: (() -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func startAuthentication() {
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
      self?.didComplete?()
    }

  }

}
