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
    setupView()
    setupLabel()
    setupImage()
  }

  private func setupView() {
    backgroundColor = .secondarySystemBackground
  }

  private func setupImage() {
    sectionImageView.tintColor = .secondaryLabel
    sectionImageView.image = sectionImage
    sectionImageView.isHidden = sectionImage == nil ? true : false
  }

  private func setupLabel() {
    sectionTitleLabel.text = sectionName
    sectionTitleLabel.textColor = .secondaryLabel
  }

}
