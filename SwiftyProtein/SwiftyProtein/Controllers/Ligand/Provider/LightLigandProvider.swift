import UIKit

protocol LightLigandProviderView: AnyObject {
  func setIsLoading(_ isLoading: Bool)
}

protocol LightLigandProviderDelegate: AnyObject {
  func didGetLigand(_ ligand: PDBLightLigand)
  func didFailGetLigand(_ error: Error)
  func didToogleLikeLigand(_ isLiked: Bool)
}

class LightLigandProvider {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  weak var view: LightLigandProviderView?
  weak var delegate: LightLigandProviderDelegate?

  var delay: TimeInterval = 0.3

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func isFavorite(ligand: String) -> Bool {
    return LocalStorage.shared.isFavorite(value: ligand)
  }

  func toggleFavorite(ligand: String) {
    if isFavorite(ligand: ligand) {
      LocalStorage.shared.remove(favorite: ligand)
      delegate?.didToogleLikeLigand(false)
    } else {
      LocalStorage.shared.add(favorite: ligand)
      delegate?.didToogleLikeLigand(true)
    }
  }

  func get(ligand: String) {
    view?.setIsLoading(true)
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
      self.getLigandRequest(ligand: ligand) { [weak self] in
        let delay: TimeInterval = self?.delay ?? 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
          self?.view?.setIsLoading(false)
        }
      }
    }
  }

  private func getLigandRequest(ligand: String,
                                completion: @escaping (() -> Void)) {
    PDBLigandProvider.shared.getLigand(ligand) { [weak self] result in
      switch result {
      case .failure(let error):
        self?.delegate?.didFailGetLigand(error)
      case .success(let ligand):
        let isFavorite = self?.isFavorite(ligand: ligand.name) ?? false
        let lightLigand = PDBLightLigand(ligand: ligand, isFavorite: isFavorite)
        self?.delegate?.didGetLigand(lightLigand)
      }
      completion()
    }
  }
}


