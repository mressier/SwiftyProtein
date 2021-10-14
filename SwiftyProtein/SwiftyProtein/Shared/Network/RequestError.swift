import Foundation

enum RequestError: Error {
  case encodeFailed
  case noData
  case noInternet
  case contentDoesNotExist
  case contentNotValid
}
