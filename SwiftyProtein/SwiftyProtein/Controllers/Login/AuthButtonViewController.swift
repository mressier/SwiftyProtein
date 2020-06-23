import UIKit
import LocalAuthentication

class AuthButtonViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var buttonImageView: UIImageView!
  @IBOutlet weak var buttonLabel: UILabel!
  @IBOutlet weak var backgroundButtonView: UIView!
  @IBOutlet weak var blurView: UIVisualEffectView!

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
      self.buttonImageView.tintColor = .systemRed
    }

    self.buttonLabel.isHidden = false
    self.buttonLabel.text = "Touch to retry"
    self.buttonLabel.textColor = .systemRed
  }

  private func authenticationIsUnavailable() {
    buttonImageView.isHidden = true
    buttonLabel.isHidden = false
  }

  private func authenticationDidSucceed() {
    let duration = TimeInterval(0.2)

    UIView.animate(withDuration: duration) {
      self.buttonImageView.tintColor = .swiftyBlueGreen
    }

    self.buttonLabel.isHidden = true
    self.buttonLabel.tintColor = .swiftyDarkBlue
    self.buttonImageView.tintColor = .swiftyDarkBlue

    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      self.didComplete?()
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupImageView()
    setupButtonLabel()
    setupBlurView()
    setupBackgroundViewAsButton()
    setupAuthProvider()
  }

  private func setupImageView() {
    guard shouldAuthenticate else {
      buttonImageView.isHidden = true
      return
    }

    buttonImageView.image = SPAssets.fingerprint.image.alwaysTemplate
    buttonImageView.tintColor = .swiftyDarkBlue
  }

  private func setupButtonLabel() {
    guard !shouldAuthenticate else {
      buttonLabel.isHidden = true
      return
    }

    buttonLabel.textColor = .swiftyDarkBlue
  }

  private func setupBlurView() {
    blurView.setAsCircle()
  }

  private func setupBackgroundViewAsButton() {
    let selector = #selector(self.authButtonDidTapped)
    let tap = UITapGestureRecognizer(target: self, action: selector)
    backgroundButtonView.addGestureRecognizer(tap)
  }

  private func setupAuthProvider() {
    authProvider.delegate = self
    authProvider.view = self
  }
}

//==============================================================================
// MARK: - Local Authentication Provider
//==============================================================================

extension AuthButtonViewController:
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
    buttonLabel.tintColor = .swiftyBlue
  }

}
