import UIKit

class LigandHeaderCollectionView: UICollectionReusableView, Reusable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var sectionTitleLabel: UILabel!
  @IBOutlet weak var sectionImageView: UIImageView!

  /******************** Parameters ********************/

  var sectionName: String? {
    didSet { setupLabel() }
  }

  var sectionImage: UIImage? {
    didSet { setupImage() }
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
    setupImage()
  }

  private func setupImage() {
    if let image = sectionImage {
      sectionImageView.tintColor = .label
      sectionImageView.image = image
      sectionImageView.isHidden = false
    } else {
      sectionImageView.isHidden = true
    }
  }

  private func setupLabel() {
    sectionTitleLabel.text = sectionName
  }

}
