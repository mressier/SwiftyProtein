import UIKit

class LigandCollectionViewCell: UICollectionViewCell, Reusable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var accessoryImageView: UIImageView!

  /******************** Parameters ********************/

  var ligandName: String? {
    didSet { titleLabel?.text = ligandName }
  }

  var accessoryImage: UIImage? {
    didSet { accessoryImageView.image = accessoryImage }
  }

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
      self.containerView.backgroundColor =
        isSelected ? .swiftyDarkBlue : .swiftyBlue

      self.containerView.cornerRadius = isSelected ? 25.0 : 21.0
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private func setup() {
    setupBackground()
    setupLabel()
  }

  private func setupBackground() {
    containerView.cornerRadius = 21.0
    containerView.borderWidth = 3.0
    containerView.backgroundColor = .swiftyBlue
    containerView.borderColor = .swiftyDarkBlue
  }

  private func setupLabel() {
    titleLabel.textColor = .white
    titleLabel?.text = ligandName
  }

  private func setupAccessoryImageView() {
    accessoryImageView.image = accessoryImage
    accessoryImageView.tintColor = .swiftyDarkBlue
  }
}
