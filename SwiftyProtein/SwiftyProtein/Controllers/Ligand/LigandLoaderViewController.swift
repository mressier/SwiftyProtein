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

  private(set) var isLoading: Bool = false

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
    guard isLoading == false else { return }

    self.ligand = ligand

    guard network.hasNetworkAccess else {
      return showMessageView(withContent: .noInternet)
    }

    ligandProvider.get(ligand: ligand)
  }

  //----------------------------------------------------------------------------
  // MARK: - Message View
  //----------------------------------------------------------------------------

  private func showMessageView(withContent content: MessageView.Content) {
    messageView.content = content
    messageView.fadeIn()
  }

  private func hideMessageView() {
    messageView.fadeOut()
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
    isLoading = false
    print(error)
    showMessageView(withContent: getMessageContent(for: error))
  }

  private func getMessageContent(for error: Error) -> MessageView.Content {
    if let error = error as? RequestError {
      switch error {
      case .noInternet: return .noInternet
      case .contentDoesNotExist: return .ligandNotFound
      case .contentNotValid: return .ligandNotReadable
      default: return .ligandDefaultError
      }
    }

    if error is PDBLigandConverter.ContentError {
      return .ligandNotReadable
    }

    return .ligandDefaultError
  }
}

//==============================================================================
// MARK: - LightLigandProviderView
//==============================================================================

extension LigandLoaderViewController: LightLigandProviderView {
  func setIsLoading(_ isLoading: Bool) {
    isLoading ? loadingView.fadeIn() : loadingView.fadeOut()
    self.isLoading = isLoading
  }
}

//==============================================================================
// MARK: - Network access
//==============================================================================

extension LigandLoaderViewController: NetworkAccessDelegate {
  func networkAccessDidChanged(_ hasNetworkAccess: Bool) {
    guard hasNetworkAccess, let ligand = ligand else { return }

    hideMessageView()
    loadLigand(ligand)
  }
}

