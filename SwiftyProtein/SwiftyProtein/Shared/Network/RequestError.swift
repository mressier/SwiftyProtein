import Foundation

enum RequestError: Error {
  case noData
  case noInternet
  case contentDoesNotExist
  case contentNotValid
}
