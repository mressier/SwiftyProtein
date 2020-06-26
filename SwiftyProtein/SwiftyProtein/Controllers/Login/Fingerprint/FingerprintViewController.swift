import UIKit
import LocalAuthentication

class FingerprintViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var fingerprintButton: FingerprintButtonView!

  /******************** Parameters ********************/

  var accessReason = "Authentify to access to very secret atoms informations"
  var authPolicy = LAPolicy.deviceOwnerAuthentication

  var shouldAuthenticate: Bool {
    return authProvider.canAuthenticate(withPolicy: authPolicy)
  }

  /******************** Authentication ********************/

  let authProvider = LocalAuthenticationProvider()

  /******************** Callback ********************/

  var didComplete: (() -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    fingerprintButton.setAsCircle()
  }

  //----------------------------------------------------------------------------
  // MARK: - Actions
  //----------------------------------------------------------------------------

  @objc private func authButtonDidTapped() {
    if shouldAuthenticate {
      startAuthentication()
    } else {
      authenticationDidSucceed()
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func startAuthentication() {
    authProvider.authenticate(
      withPolicy: authPolicy,
      accessReason: accessReason
    )
  }

  private func authenticationDidFailed() {
    UIView.animate(withDuration: 0.2) {
      self.fingerprintButton.setAsFailure(message: "Touch to retry")
    }
  }

  private func authenticationIsUnavailable() {
    fingerprintButton.setAsDefault(message: "Enter")
    fingerprintButton.hideFingerprintImage()
  }

  private func authenticationDidSucceed() {
    let duration = TimeInterval(0.2)

    UIView.animate(withDuration: duration) {
      self.fingerprintButton.setAsSuccess()
    }

    didComplete?()
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupFingerprintButton()
    setupFingerprintButtonAction()
    setupAuthProvider()
  }

  private func setupFingerprintButton() {
    fingerprintButton.setAsCircle()
    fingerprintButton.successColor = .swiftyBlueGreen
    fingerprintButton.failureColor = .systemRed
    fingerprintButton.defaultColor = .swiftyDarkBlue
    fingerprintButton.setAsDefault(message: "Enter")

    guard shouldAuthenticate else {
      fingerprintButton.hideFingerprintImage()
      return
    }
  }

  private func setupFingerprintButtonAction() {
    let selector = #selector(self.authButtonDidTapped)
    let tap = UITapGestureRecognizer(target: self, action: selector)
    fingerprintButton.addGestureRecognizer(tap)
  }

  private func setupAuthProvider() {
    authProvider.delegate = self
    authProvider.view = self
  }
}

//==============================================================================
// MARK: - Local Authentication Provider
//==============================================================================

extension FingerprintViewController:
  LocalAuthenticationDelegate,
  LocalAuthenticationView
{
  func didAuthenticate() {
    authenticationDidSucceed()
  }

  func didFailAuthentication(_ error: LocalAuthenticationError) {
    switch error {
    case .authenticationFailed: authenticationDidFailed()
    case .authenticationUnavailable: authenticationIsUnavailable()
    }
  }

  func didStartAuthentication() {
  }

}
