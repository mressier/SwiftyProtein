import UIKit

class AtomBuilder {
  static func build() -> [PDBAtomLight] {
    return FakeLigands.atp
  }

  static func build(
    ligand: String,
    completion: @escaping ((Result<[PDBAtomLight], Error>) -> Void)
  ) {
    PDBLigandProvider.getLigand(ligand) { result in
      switch result {
      case .failure(let error): completion(.failure(error))
      case .success(let ligand):
        let lightLigand = ligand.atoms.map() { $0.lightAtom }
        completion(.success(lightLigand))
      }
    }
  }
}


