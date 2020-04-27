import UIKit

class LigandHeaderCollectionView: UICollectionReusableView, Reusable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var titleLabel: UILabel!

  /******************** Parameters ********************/

  var sectionName: String? {
    didSet { titleLabel.text = sectionName }
  }

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  private func setup() {
    setupLabel()
  }

  private func setupLabel() {
    titleLabel.text = sectionName
  }

}
