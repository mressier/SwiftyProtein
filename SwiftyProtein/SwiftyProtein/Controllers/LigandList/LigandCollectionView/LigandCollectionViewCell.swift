import UIKit

class LigandCollectionViewCell: UICollectionViewCell, Reusable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var accessoryImageView: UIImageView!
  @IBOutlet weak var mainImageView: UIImageView!

  /******************** Parameters ********************/

  var ligandName: String? {
    didSet { titleLabel?.text = ligandName }
  }

  var accessoryImage: UIImage? {
    didSet { accessoryImageView.image = accessoryImage }
  }

  var mainImage: UIImage? {
    didSet {
      mainImageView.image = mainImage
      mainImageView.isHidden = mainImage == nil
    }
  }

  /******************** UI Parameters ********************/

  var unselectedBackgroundColor: UIColor = .systemBackground
  var selectedBackgroundColor: UIColor = .systemFill

  var labelColor: UIColor = .label
  var accessoryColor: UIColor = .appTintColor

  /******************** Override ********************/

  override var isSelected: Bool {
    didSet { setSelected(isSelected) }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  func setSelected(_ isSelected: Bool) {
    UIView.animate(withDuration: 0.2) {
      self.updateView(isSelected: isSelected)
    }
  }

  private func updateView(isSelected: Bool) {
    containerView.backgroundColor =
      isSelected ? selectedBackgroundColor : unselectedBackgroundColor
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private func setup() {
    setupBackground()
    setupLabel()
    setupAccessoryImageView()
  }

  private func setupBackground() {
    containerView.borderWidth = 1.0
    containerView.backgroundColor = unselectedBackgroundColor
    containerView.borderColor = selectedBackgroundColor
  }

  private func setupLabel() {
    titleLabel.textColor = labelColor
    titleLabel.font = .boldSystemFont(ofSize: 20.0)
    titleLabel?.text = ligandName
  }

  private func setupAccessoryImageView() {
    accessoryImageView.image = accessoryImage
    accessoryImageView.tintColor = accessoryColor
  }
}
