import UIKit

class LigandCollectionViewCell: UICollectionViewCell, Reusable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var accessoryImageView: UIImageView!

  var ligandName: String? {
    didSet { titleLabel?.text = ligandName }
  }

  var accessoryImage: UIImage? {
    didSet { accessoryImageView.image = accessoryImage }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }

  private func setup() {
    setupBackground()
    setupLabel()
  }

  private func setupBackground() {
    containerView.cornerRadius = 21.0
    containerView.borderWidth = 3.0
    containerView.backgroundColor = .systemBlue // TEMP
    containerView.borderColor = .blue // TEMP
  }

  private func setupLabel() {
    titleLabel.textColor = .white
    titleLabel?.text = ligandName
  }

  private func setupAccessoryImageView() {
    accessoryImageView.image = accessoryImage
  }
}
