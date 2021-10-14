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
    coordinateModel: PDBCoordinateModel,
    completion: @escaping (Result<String, Error>) -> Void
  ) {
    let ligand = ligand
      .trimmed()
      .addingPercentEncoding(withAllowedCharacters: .alphanumerics)

    guard let escapedLigand = ligand, !escapedLigand.isEmpty else {
      completion(.failure(RequestError.encodeFailed))
      return
    }

    let prefix = "http://ligand-expo.rcsb.org/reports/"
    let suffix = "_\(coordinateModel.urlExtension).pdb"

    let url = URLBuilder.build(forLigand: escapedLigand,
                               urlPrefix: prefix,
                               urlSuffix: suffix)

    print("Search ligand: \(escapedLigand)")

    NetworkRequest.shared.get(url) { result in
      switch result {
      case .failure(let error): completion(.failure(error))
      case .success(let data):
        let content = String(decoding: data, as: UTF8.self)
        completion(.success(content))
      }
    }
  }
}
