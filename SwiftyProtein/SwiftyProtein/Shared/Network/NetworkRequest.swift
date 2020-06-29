import Foundation
import Alamofire

struct NetworkRequest {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  static let shared = NetworkRequest()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private init() {}

  //----------------------------------------------------------------------------
  // MARK: - Requests
  //----------------------------------------------------------------------------

  func get(_ url: String,
           completion: @escaping ((Result<Data, Error>) -> Void)) {
    AF.request(url).response { result in
      if let error = self.getError(from: result) {
        completion(.failure(error))
        return
      }

      guard let data = result.data else {
        completion(.failure(RequestError.noData))
        return
      }

      completion(.success(data))
    }
  }

  private func getError(from result: AFDataResponse<Data?>) -> Error? {
    if result.response?.statusCode == 404 {
      return RequestError.contentDoesNotExist
    }

    guard let afError = result.error,
      let urlError = afError.underlyingError as? URLError else {
        return result.error
    }

    if urlError.code.rawValue == NSURLErrorNotConnectedToInternet {
      return RequestError.noInternet
    }

    return nil
  }
  
}
