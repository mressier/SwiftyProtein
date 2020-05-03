import UIKit

class LightLigandProvider {

  static func get(
    ligand: String,
    completion: @escaping ((Result<PDBLightLigand, Error>) -> Void)
  ) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      PDBLigandProvider.getLigand(ligand) { result in
        switch result {
        case .failure(let error): completion(.failure(error))
        case .success(let ligand):
          completion(.success(PDBLightLigand(ligand: ligand)))
        }
      }
    }
  }
}


