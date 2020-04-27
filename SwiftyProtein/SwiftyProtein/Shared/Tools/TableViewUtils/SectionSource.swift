import UIKit

/*******************************************************************************
 * SectionSource
 *
 * Common source for table view based on object ( `[section: String, content: [Element]] `)
 *
 ******************************************************************************/
class SectionSource<Section, Element: Equatable>: CollectionSource {

  typealias ElementType = Element

  typealias Sections = [(section: Section, content: [Element])]

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Content ********************/

  var elements = Sections()

  //----------------------------------------------------------------------------
  // MARK: - Data source
  //----------------------------------------------------------------------------

  func element(at indexPath: IndexPath) -> Element {
    return elements(inSection: indexPath.section)[indexPath.row]
  }

  func elements(inSection section: Int) -> [Element] {
    return elements[section].content
  }

  /******************** Index Path ********************/

  func indexPath(for element: Element) -> IndexPath? {
    for (sectionIndex, section) in elements.enumerated() {
      if let rowIndex = section.content.firstIndex(where: { $0 == element }) {
        return IndexPath(row: rowIndex, section: sectionIndex)
      }
    }
    return nil
  }

  func indexPaths(for elements: [Element]) -> [IndexPath] {
    return elements.compactMap() { indexPath(for: $0) }
  }

  /******************** Section Key ********************/

  func sectionKey(at indexPath: IndexPath) -> Section {
    return sectionKey(at: indexPath.section)
  }

  func sectionKey(at index: Int) -> Section {
    return elements[index].section
  }

}
