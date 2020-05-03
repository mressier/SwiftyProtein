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

  /********************  Callback ********************/

  var didSelectLigand: ((LigandCollection.Ligand) -> Void)?

  /******************** Views ********************/

  private lazy var scrollBar: ScrollBarView = {
    return ScrollBarView()
  }()

  /******************** Layout ********************/

  private lazy var layout: LigandCollectionViewFlowLayout = {
    return LigandCollectionViewFlowLayout()
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
    collectionView.collectionViewLayout = layout
  }

  private func setupSource() {
    reloadData()
  }

  func reloadData() {
    source.elements = ligandsList
    collectionView.reloadData()
  }

  //----------------------------------------------------------------------------
  // MARK: - Scroll Bar
  //----------------------------------------------------------------------------

  private func setupScrollBar() {
    collectionView.superview?.add(subview: scrollBar, with: .trailing)

    scrollBar.didScrollTo = { [weak self] percent in
      self?.scrollTo(percentOfViewHeight: percent)
    }

    scrollBar.didBeginScroll = { [weak self] in
      self?.scrollBar.showScrollBar()
    }

    scrollBar.didEndScroll = { [weak self] in
      self?.scrollBar.hideScrollBar()
    }

    scrollBar.hideScrollBar()
  }

  private func scrollTo(percentOfViewHeight percent: CGFloat) {
    let visibleHeight = collectionView.visibleSize.height
    let usableHeight = collectionView.contentSize.height - visibleHeight
    let yOffset = usableHeight * percent

    collectionView.contentOffset.y = yOffset.clamped(min: 0, max: usableHeight)
    setScrollSectionLabel()
  }

  private func setScrollSectionLabel() {
    let section = collectionView.topVisibleSection
    let sectionName = source.sectionKey(at: section).title

    scrollBar.scrollLabel.text = sectionName
  }
}

//==============================================================================
// MARK: - UICollection Data Soure
//==============================================================================

extension LigandCollectionViewController {

  /******************** Number of sections ********************/

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return source.elements.count
  }

  /******************** Number of items in section ********************/

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return source.elements(inSection: section).count
  }

  /******************** View for supplementary element of kind ********************/

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
      headerView.sectionImage = section.image?.alwaysTemplate
    }

    return headerView
  }

  /******************** Cell for item at ********************/

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

  /******************** Did select item at ********************/

  override func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
    let item = source.element(at: indexPath)
    didSelectLigand?(item)
  }

}

//==============================================================================
// MARK: - Scroll View Delegate
//==============================================================================

extension LigandCollectionViewController {

  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollBar.isScrolling { return }

    scrollBar.scroll(to: scrollView.contentOffsetPercent.height)
    setScrollSectionLabel()
  }

  override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    if scrollBar.isScrolling { return }

     scrollBar.hideScrollBar()
  }

  override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    scrollBar.showScrollBar()
  }
}
