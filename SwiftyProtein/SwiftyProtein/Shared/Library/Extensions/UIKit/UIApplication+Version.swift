import UIKit

extension UIApplication {

  var melomindVersion: String {
    #if DEBUG
    let typeVersion = "-debug"
    #elseif PRERELEASE
    let typeVersion = "-prerelease"
    #else
    let typeVersion = ""
    #endif

    return BundleConstants.versionMobile + typeVersion
  }

}
