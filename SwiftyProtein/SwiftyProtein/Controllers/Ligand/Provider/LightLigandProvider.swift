import UIKit

protocol LightLigandProviderView: class {
  func setIsLoading(_ isLoading: Bool)
}

protocol LightLigandProviderDelegate: class {
  func didGetLigand(_ ligand: PDBLightLigand)
  func didFailGetLigand(_ error: Error)
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
    PDBLigandProvider.getLigand(ligand) { [weak self] result in
      switch result {
      case .failure(let error):
        self?.delegate?.didFailGetLigand(error)
      case .success(let ligand):
        let lightLigand = PDBLightLigand(ligand: ligand)
        self?.delegate?.didGetLigand(lightLigand)
      }
      completion()
    }
  }
}


