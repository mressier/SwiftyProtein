import UIKit

extension UICollectionView {
  var visibleSections: [Int] {
    return visibleCells.compactMap() { indexPath(for: $0)?.section }
  }

  var topVisibleSection: Int {
    return visibleSections.lowest ?? 0
  }
}
