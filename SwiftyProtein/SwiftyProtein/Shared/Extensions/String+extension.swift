import UIKit

extension String {

  //----------------------------------------------------------------------------
  // MARK: - Trim
  //----------------------------------------------------------------------------

  func trimmed() -> String {
    guard let firstNotSpace = self.firstIndex(where: { !$0.isWhitespace }),
      let lastNotSpace = self.lastIndex(where: { !$0.isWhitespace }) else {
        return ""
    }

    return String(self[firstNotSpace ... lastNotSpace])
  }
}
