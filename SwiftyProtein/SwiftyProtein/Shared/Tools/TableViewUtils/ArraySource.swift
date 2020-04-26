import UIKit

/*******************************************************************************
 * ArraySource
 *
 * Common source for table view based on 2d arrays ( `[section[row]] `)
 *
 ******************************************************************************/
class ArraySource<Element: Equatable>: CollectionSource {

  typealias ElementType = Element

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Content ********************/

  var elements: [[Element]] = [[]]

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  func element(at indexPath: IndexPath) -> Element {
    return elements(inSection: indexPath.section)[indexPath.row]
  }

  func elements(inSection section: Int) -> [Element] {
    return elements[section]
  }

  func indexPath(for element: Element) -> IndexPath? {
    for (sectionIndex, section) in elements.enumerated() {
      if let rowIndex = section.firstIndex(where: { $0 == element }) {
        return IndexPath(row: rowIndex, section: sectionIndex)
      }
    }
    return nil
  }

  func indexPaths(for elements: [Element]) -> [IndexPath] {
    return elements.compactMap() { indexPath(for: $0) }
  }
}
