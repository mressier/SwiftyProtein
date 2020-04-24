import UIKit

class LightLigandProvider {
  static func build() -> [PDBAtomLight] {
    return FakeLigands.atp
  }

  static func build(
    ligand: String,
    completion: @escaping ((Result<PDBLigandLight, Error>) -> Void)
  ) {
    PDBLigandProvider.getLigand(ligand) { result in
      switch result {
      case .failure(let error): completion(.failure(error))
      case .success(let ligand):
        completion(.success(PDBLigandLight(ligand: ligand)))
      }
    }
  }
}


