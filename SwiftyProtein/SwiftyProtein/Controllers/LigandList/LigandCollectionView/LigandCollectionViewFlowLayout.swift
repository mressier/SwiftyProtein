import UIKit

class LigandCollectionViewFlowLayout: LeftAlignedCollectionViewFlowLayout {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let expectedCellWidth = CGFloat(100)
  let minimumNumberOfItems = 4
  let headerSize = CGSize(width: 100, height: 28)
  let sectionPadding = CGFloat(18.0)
  let cellPadding = CGFloat(0)

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init() {
    super.init()
    sectionInset = UIEdgeInsets(top: sectionPadding,
                                left: sectionPadding,
                                bottom: sectionPadding,
                                right: sectionPadding)
    scrollDirection = .vertical
    minimumInteritemSpacing = cellPadding
    minimumLineSpacing = cellPadding
    headerReferenceSize = headerSize
    sectionHeadersPinToVisibleBounds = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepare() {
    super.prepare()
    updateEstimatedItemSize()
  }

  /******************** Invalidate layout ********************/

  override func shouldInvalidateLayout(
    forBoundsChange newBounds: CGRect
  ) -> Bool {
    guard let collectionView = collectionView else { return false }

    let oldSize = collectionView.bounds.size
    guard oldSize != newBounds.size else { return false }

    updateEstimatedItemSize()
    return true
  }

  //----------------------------------------------------------------------------
  // MARK: - Cell Size
  //----------------------------------------------------------------------------

  private func updateEstimatedItemSize() {
    guard let collectionView = collectionView else { return }
    estimatedItemSize = widthRelatedCellSize(with: collectionView)
  }

  private func widthRelatedCellSize(
    with collectionView: UICollectionView
  ) -> CGSize {
    let contentInset = collectionView.contentInset
    let padding = sectionPadding * 2 + contentInset.left + contentInset.right
    let width = collectionView.bounds.size.width - padding

    let number = max(minimumNumberOfItems, Int(width / expectedCellWidth) + 1)
    let size = Int(width / CGFloat(number))

    return CGSize(width: size, height: size)
  }
}
