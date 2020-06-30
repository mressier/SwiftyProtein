import Foundation

/*******************************************************************************
 * DictionnarySource
 *
 * Common source for table view based on a dictionnary with [sectionName: [Content]]
 *
 ******************************************************************************/
class DictionnarySource<Element: Equatable>: CollectionSource {

  typealias ElementType = Element

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Content ********************/

  /// Content of the table view by sections
  var elements: [String: [Element]] = [:]

  /// Method used to sort sections
  var sortSection: ((String, String) -> Bool) = { s1, s2 in s1 < s2 }

  /******************** Section content ********************/

  func sectionKey(at index: Int) -> String? {
    guard index >= 0 && index < elements.count else { return nil }
    return Array(elements.keys)[index]
  }

  func sectionKey(at indexPath: IndexPath) -> String? {
    return sectionKey(at: indexPath.section)
  }

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  func element(at indexPath: IndexPath) -> Element {
    return elements(inSection: indexPath.section)[indexPath.row]
  }

  func elements(inSection section: Int) -> [Element] {
    guard let key = sectionKey(at: section) else { return [] }
    return elements[key] ?? []
  }

  func indexPath(for element: Element) -> IndexPath? {
    for (index, key) in elements.keys.enumerated() {
      if let rowIndex = elements[key]?.firstIndex(where: { $0 == element }) {
        return IndexPath(row: rowIndex, section: index)
      }
    }
    return nil
  }

  func indexPaths(for elements: [Element]) -> [IndexPath] {
    return elements.compactMap() { indexPath(for: $0) }
  }
}
