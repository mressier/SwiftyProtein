import UIKit

private let cellIdentifier = "proteinCell"

class ProteinCollectionViewController: UICollectionViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Parameters ********************/

  var ligands = [String]()
  var favorites = [String]()

  private var source = ArraySource<String>()

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
    let nibName = UINib(nibName: ProteinCollectionViewCell.reuseIdentifier,
                        bundle: .main)
    collectionView.register(nibName,
                            forCellWithReuseIdentifier: cellIdentifier)
  }

  private func setupSource() {
    source.elements = [ligands]
    collectionView.reloadData()
  }

}

//==============================================================================
// MARK: - UICollection Data Soure
//==============================================================================

extension ProteinCollectionViewController {

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return source.elements.count
  }


  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return source.elements(inSection: section).count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                  for: indexPath)
    if let cell = cell as? ProteinCollectionViewCell {
      let ligand = source.element(at: indexPath)
      cell.proteinName = ligand
    }
    // Configure the cell
    
    return cell
  }

}
