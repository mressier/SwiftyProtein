import Network
import UIKit

protocol NetworkAccessor {
  var hasNetworkAccess: Bool { get }
}

protocol NetworkAccessDelegate: class {
  func networkAccessDidChanged(_ hasNetworkAccess: Bool)
}

/*******************************************************************************
 * NetworkAccess
 *
 * Quick access to network access informations
 *
 ******************************************************************************/
class NetworkAccess: NetworkAccessor {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Network Accessor ********************/

  var hasNetworkAccess: Bool {
    return pathStatus == .satisfied
  }

  /******************** Delegate ********************/

  weak var delegate: NetworkAccessDelegate?

  /******************** Private ********************/

  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue(label: "Monitor")
  private var pathStatus: NWPath.Status = .requiresConnection

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(delegate: NetworkAccessDelegate? = nil) {
    self.monitor.pathUpdateHandler = { path in
      self.pathStatus = path.status
      DispatchQueue.main.async {
        self.delegate?.networkAccessDidChanged(self.hasNetworkAccess)
      }
    }
    self.pathStatus = monitor.currentPath.status
    self.delegate = delegate
    self.monitor.start(queue: queue)
  }

  deinit {
    self.monitor.cancel()
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

}


