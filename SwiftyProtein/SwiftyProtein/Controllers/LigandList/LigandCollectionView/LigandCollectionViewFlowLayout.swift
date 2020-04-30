import UIKit

class LigandCollectionViewFlowLayout: LeftAlignedCollectionViewFlowLayout {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let cellSize = CGSize(width: 100, height: 100)
  let headerSize = CGSize(width: 100, height: 28)
  let padding = CGFloat(18.0)

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init() {
    super.init()
    sectionInset =
      UIEdgeInsets(top: padding, left: padding, bottom: padding, right: 30)
    sectionHeadersPinToVisibleBounds = true
    sectionHeadersPinToVisibleBounds = true
    scrollDirection = .vertical
    minimumInteritemSpacing = padding
    minimumLineSpacing = padding
    headerReferenceSize = headerSize
    itemSize = cellSize
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
