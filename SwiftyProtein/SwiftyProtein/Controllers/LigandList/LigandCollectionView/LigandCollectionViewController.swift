import UIKit

private let cellIdentifier = "ligandCell"
private let headerIdentifier = "ligandHeaderView"

class LigandCollectionViewController: UICollectionViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Parameters ********************/

  var ligands = [String]()
  var favorites = [String]()

  private var source = DictionnarySource<String>()

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
    let nibName = UINib(nibName: LigandCollectionViewCell.reuseIdentifier,
                        bundle: .main)
    collectionView.register(nibName,
                            forCellWithReuseIdentifier: cellIdentifier)

    let nibHeader = UINib(nibName: LigandHeaderCollectionView.reuseIdentifier,
                          bundle: .main)
    collectionView.register(nibHeader,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: headerIdentifier)
  }

  private func setupSource() {
    source.elements = ["favoris": ["A"], "ligands": ligands]
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
      headerView.sectionName = section
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
      cell.ligandName = ligand
    }
    // Configure the cell
    
    return cell
  }

}
