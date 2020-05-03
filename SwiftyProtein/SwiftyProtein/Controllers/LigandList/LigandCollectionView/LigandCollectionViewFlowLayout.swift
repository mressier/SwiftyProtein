import UIKit

class LigandCollectionViewFlowLayout: LeftAlignedCollectionViewFlowLayout {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let cellSize = CGSize(width: 100, height: 100)
  let headerSize = CGSize(width: 100, height: 28)
  let sectionPadding = CGFloat(18.0)
  let cellPadding = CGFloat(0)

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init() {
    super.init()
    sectionInset =
      UIEdgeInsets(top: sectionPadding,
                   left: sectionPadding,
                   bottom: sectionPadding,
                   right: 30)
    sectionHeadersPinToVisibleBounds = true
    sectionHeadersPinToVisibleBounds = true
    scrollDirection = .vertical
    minimumInteritemSpacing = cellPadding
    minimumLineSpacing = cellPadding
    headerReferenceSize = headerSize
    itemSize = cellSize
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
