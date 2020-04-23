import Foundation

struct PDBRequest {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  static let shared = PDBRequest()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private init() {}

  //----------------------------------------------------------------------------
  // MARK: - Requests
  //----------------------------------------------------------------------------

  func getPDBFileContent(
    forLigand ligand: String,
    completion: @escaping (Result<String, Error>) -> Void
  ) {
    let prefix = "http://ligand-expo.rcsb.org/reports/"
    let suffix = "_ideal.pdb"
    let url = URLBuilder.build(forLigand: ligand,
                               urlPrefix: prefix,
                               urlSuffix: suffix)

    NetworkRequest.get(url) { result in
      switch result {
      case .failure(let error): completion(.failure(error))
      case .success(let data):
        let content = String(decoding: data, as: UTF8.self)
        completion(.success(content))
      }
    }
  }
}
