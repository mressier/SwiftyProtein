import Foundation
import LocalAuthentication

protocol LocalAuthenticationDelegate: class {
  func didAuthenticate()
  func didFailAuthentication(_ error: LocalAuthenticationError)
}

protocol LocalAuthenticationView: class {
  func didStartAuthentication()
}

/*******************************************************************************
 * LocalAuthenticationProvider
 *
 * Provide access to local authentication (such as TouchID, faceID, pin code, etc.)
 *
 ******************************************************************************/
class LocalAuthenticationProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Parameters ********************/

  weak var delegate: LocalAuthenticationDelegate?
  weak var view: LocalAuthenticationView?

  /******************** Authenticate ********************/

  private lazy var context: LAContext = {
    return LAContext()
  }()

  private var error: NSError?

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /// Try to authentication with the given policy
  func authenticate(withPolicy policy: LAPolicy,
                    accessReason: String,
                    cancelMessage: String = "Cancel",
                    fallbackMessage: String? = nil) {
    context.localizedCancelTitle = cancelMessage
    context.localizedFallbackTitle = fallbackMessage
    view?.didStartAuthentication()

    guard canAuthenticate(withPolicy: policy) else {
      delegate?.didFailAuthentication(.authenticationUnavailable(error))
      return
    }

    context.evaluatePolicy(policy, localizedReason: accessReason)
    { [weak self] success, error in
      print("Got error ? \(String(describing: error))")
      DispatchQueue.main.async {
        success ? self?.delegate?.didAuthenticate()
          : self?.delegate?.didFailAuthentication(.authenticationFailed(error))
      }
      return
    }
  }

  /// Check if authentication is possible with the given policy. Return nil if ok, or an error if an error occurs.
  func canAuthenticate(withPolicy policy: LAPolicy) -> Bool {
    return context.canEvaluatePolicy(policy, error: &error)
  }
}
