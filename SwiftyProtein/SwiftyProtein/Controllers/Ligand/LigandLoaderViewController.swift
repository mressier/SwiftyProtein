import UIKit

class LigandLoaderViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private weak var messageView: MessageView!
  @IBOutlet private weak var loadingView: LoadingView!
  @IBOutlet private weak var scrollView: UIScrollView!

  /******************** Providers ********************/

  private let ligandProvider = LightLigandProvider()

  private let network = NetworkAccess()

  /******************** Parameters ********************/

  private(set) var ligand: String?

  /******************** Callbacks ********************/

  var didComplete: ((PDBLightLigand) -> Void)?

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()

    if !network.hasNetworkAccess {
      messageView.content = .noInternet
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func loadLigand(_ ligand: String) {
    self.ligand = ligand

    guard network.hasNetworkAccess else {
      messageView.content = .noInternet
      messageView.fadeIn()
      return
    }
    ligandProvider.get(ligand: ligand)
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupMessageView()
    setupLoadingView()
    setupProvider()
    setupNetworkAccess()
  }

  private func setupMessageView() {
    messageView.alpha = 0.0
  }

  private func setupLoadingView() {
    loadingView.alpha = 0.0
    loadingView.loadingText = "Loading..."
  }

  private func setupProvider() {
    ligandProvider.view = self
    ligandProvider.delegate = self
  }

  private func setupNetworkAccess() {
    network.delegate = self
  }

}

//==============================================================================
// MARK: - LightLigandProviderDelegate
//==============================================================================

extension LigandLoaderViewController: LightLigandProviderDelegate {
  func didGetLigand(_ ligand: PDBLightLigand) {
    didComplete?(ligand)
    messageView.fadeOut()
  }

  func didFailGetLigand(_ error: Error) {
    print(error)
    messageView.content = .ligandNotFound
    messageView.fadeIn()
  }
}

//==============================================================================
// MARK: - LightLigandProviderView
//==============================================================================

extension LigandLoaderViewController: LightLigandProviderView {
  func setIsLoading(_ isLoading: Bool) {
    isLoading ? loadingView.fadeIn() : loadingView.fadeOut()
  }
}

//==============================================================================
// MARK: - Network access
//==============================================================================

extension LigandLoaderViewController: NetworkAccessDelegate {
  func networkAccessDidChanged(_ hasNetworkAccess: Bool) {
    guard hasNetworkAccess else { return }
    guard let ligand = ligand else { return }

    messageView.fadeOut()

    loadLigand(ligand)
  }
}

