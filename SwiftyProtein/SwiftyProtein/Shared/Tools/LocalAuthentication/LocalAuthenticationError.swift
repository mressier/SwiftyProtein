import Foundation

enum LocalAuthenticationError: Error {
  case authenticationUnavailable(_ error: Error?)
  case authenticationFailed(_ error: Error?)
}
