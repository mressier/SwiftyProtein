import UIKit

/*******************************************************************************
 * AlertViewType
 *
 * Different kind of alert that can be shown
 *
 ******************************************************************************/
enum AlertViewType {
  case warning
  case error
  case info
  case `default`

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var backgroundColor: UIColor {
    switch self {
    case .default: return .secondarySystemBackground
    case .error: return .systemRed
    case .info: return .systemBlue
    case .warning: return .systemOrange
    }
  }

  var labelColor: UIColor? {
    switch self {
    case .default: return .secondaryLabel
    default: return .label
    }
  }
}
