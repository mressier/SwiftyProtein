import Foundation
import Alamofire

struct PDBLigandProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  static let shared = PDBLigandProvider()

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private init() {}

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func getLigand(
    _ name: String,
    completion: @escaping ((Result<PDBLigand, Error>) -> Void)
  ) {
    getLigand(name, coordinatesModel: .ideal) { result in
      guard case .failure(let error) = result,
        let requestError = error as? RequestError,
        requestError == .noData else {
        completion(result)
        return
      }

      self.getLigand(name,
                     coordinatesModel: .experimental,
                     completion: completion)
    }
  }

  func getLigand(_ name: String,
                 coordinatesModel: PDBCoordinateModel,
                 completion: @escaping ((Result<PDBLigand, Error>) -> Void)) {

    PDBRequest.shared.getPDBFileContent(forLigand: name,
                                        coordinateModel: coordinatesModel)
    { result in
      switch result {
      case .failure(let error): completion(.failure(error))
      case .success(let fileContent):
        do {
          let ligand =
            try PDBLigandConverter.ligand(name: name, from: fileContent)
          completion(.success(ligand))
        } catch {
          completion(.failure(error))
        }
      }
    }
  }
}
