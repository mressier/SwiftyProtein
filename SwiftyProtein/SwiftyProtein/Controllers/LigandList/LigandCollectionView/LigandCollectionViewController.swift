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

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    setupCollectionView()
    setupSource()
  }

  private func setupCollectionView() {
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

  private func setupSource() {
    source.elements = ligandsList

    collectionView.reloadData()
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
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                  for: indexPath)
    if let cell = cell as? LigandCollectionViewCell {
      let ligand = source.element(at: indexPath)
      cell.ligandName = ligand.name
      cell.accessoryImage = ligand.isFavorite ?
        SPAssets.heartFilled.image.alwaysTemplate : nil
    }
    
    return cell
  }

}
