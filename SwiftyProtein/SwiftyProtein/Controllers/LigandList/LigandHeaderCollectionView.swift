import UIKit

class LigandHeaderCollectionView: UICollectionReusableView, Reusable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var titleLabel: UILabel!

  /******************** Parameters ********************/

  var titleText: String?
  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

}
