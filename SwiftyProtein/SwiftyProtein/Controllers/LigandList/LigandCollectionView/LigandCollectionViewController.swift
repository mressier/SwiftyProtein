import UIKit

private let cellIdentifier = "ligandCell"
private let headerIdentifier = "ligandHeaderView"

typealias LigandSectionSource =
  SectionSource<LigandCollection.Header, LigandCollection.Ligand>

class LigandCollectionViewController: UICollectionViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Parameters ********************/

  private var source = LigandSectionSource()

  /// List of ligands splitted in sections to display
  var ligandsList = LigandSectionSource.Sections()

  /******************** Collection View ********************/

  let cellSize = CGSize(width: 100, height: 100)
  let headerSize = CGSize(width: 100, height: 28)
  let padding = CGFloat(18.0)

  /******************** Views ********************/


  private lazy var scrollBar: ScrollBarView = {
    return ScrollBarView()
  }()

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    setupCollectionView()
    setupScrollBar()
    setupSource()
  }

  private func setupCollectionView() {
    setupCollectionViewLayout()
    setupCollectionViewCells()
    setupCollectionViewReusableView()
  }

  private func setupCollectionViewCells() {
    let nibName = UINib(nibName: LigandCollectionViewCell.reuseIdentifier,
                        bundle: .main)
    collectionView.register(nibName,
                            forCellWithReuseIdentifier: cellIdentifier)
  }

  private func setupCollectionViewReusableView() {
    let nibHeader = UINib(nibName: LigandHeaderCollectionView.reuseIdentifier,
                          bundle: .main)
    collectionView.register(
      nibHeader,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: headerIdentifier
    )
  }

  private func setupCollectionViewLayout() {
    let layout = LeftAlignedCollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: padding,
                                       left: padding,
                                       bottom: padding,
                                       right: 30)
    layout.sectionHeadersPinToVisibleBounds = true
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = padding
    layout.minimumLineSpacing = padding

    layout.headerReferenceSize = headerSize
    layout.itemSize = cellSize
    collectionView.collectionViewLayout = layout
  }

  private func setupSource() {
    source.elements = ligandsList

    collectionView.reloadData()
  }

  private func setupScrollBar() {
    collectionView.superview?.add(subview: scrollBar, with: .trailing)

    scrollBar.didScrollTo = { [weak self] percent in
      guard let self = self else { return }
      let scrollViewHeight = self.collectionView.visibleSize.height
      let collectionViewUsableHeight =
        self.collectionView.contentSize.height - scrollViewHeight
      let newOffset = collectionViewUsableHeight * percent

      self.collectionView.contentOffset.y =
        newOffset.clamped(min: 0, max: collectionViewUsableHeight)
    }

    scrollBar.didBeginScroll = { [weak self] in
      self?.scrollBar.showScrollBar()
    }

    scrollBar.didEndScroll = { [weak self] in
      self?.scrollBar.hideScrollBar()
    }

    scrollBar.hideScrollBar()
  }

}

//==============================================================================
// MARK: - UICollection Data Soure
//==============================================================================

extension LigandCollectionViewController {

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return source.elements.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return source.elements(inSection: section).count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
  ) -> UICollectionReusableView {

    let headerView = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: headerIdentifier,
      for: indexPath
    )

    if let headerView = headerView as? LigandHeaderCollectionView {
      let section = source.sectionKey(at: indexPath)

      headerView.sectionName = section.title
      headerView.sectionImage = section.image
    }

    return headerView
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell =
      collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                         for: indexPath)
    if let cell = cell as? LigandCollectionViewCell {
      let ligand = source.element(at: indexPath)
      cell.ligandName = ligand.name
      cell.accessoryImage = ligand.isFavorite ?
        SPAssets.heartFilled.image.alwaysTemplate : nil
    }
    
    return cell
  }

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollBar.isScrolling { return }
    scrollBar.scroll(to: scrollView.contentOffsetPercent.height)
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
     scrollBar.hideScrollBar()
  }

  override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    scrollBar.showScrollBar()
  }

}
