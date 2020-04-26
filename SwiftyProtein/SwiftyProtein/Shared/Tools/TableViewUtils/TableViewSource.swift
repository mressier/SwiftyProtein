import UIKit

/*******************************************************************************
 * TableViewSource
 *
 * A common set of properties to implement by sources for table view
 *
 ******************************************************************************/
protocol CollectionSource {
  associatedtype ElementType

  func elements(inSection section: Int) -> [ElementType]
  func element(at indexPath: IndexPath) -> ElementType
}
