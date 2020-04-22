import Foundation
import Alamofire

struct PDBLigandProvider {

  static func getLigand(
    _ name: String,
    completion: @escaping ((Result<PDBLigand, Error>) -> Void)
  ) {
    PDBRequest.shared.getPDBFileContent(forLigand: name) { result in
      switch result {
      case .failure(let error): completion(.failure(error))
      case .success(let fileContent):
        do {
          let ligand = try PDBLigandConverter.ligand(from: fileContent)
          completion(.success(ligand))
        } catch {
          completion(.failure(error))
        }
      }
    }
  }
}
