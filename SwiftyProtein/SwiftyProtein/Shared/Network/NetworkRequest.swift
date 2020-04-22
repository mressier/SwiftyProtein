import Foundation
import Alamofire

struct NetworkRequest {

  //----------------------------------------------------------------------------
  // MARK: - Requests
  //----------------------------------------------------------------------------

  static func get(_ url: String,
                  completion: @escaping ((Result<Data, Error>) -> Void)) {
    AF.request(url).response { result in
      guard let data = result.data else {
        if let error = result.error {
          completion(.failure(error))
        } else {
          completion(.failure(RequestError.noData))
        }
        return
      }

      completion(.success(data))
    }
  }

  
}
