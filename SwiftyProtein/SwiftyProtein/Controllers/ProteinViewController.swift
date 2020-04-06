import UIKit

class ProteinViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  @IBOutlet weak var proteinSceneContainerView: UIView!


  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  private func setup() {
    // ...
  }

  private func setupProteinSceneVC() {
    let proteinSceneVC = ProteinViewController(nibName: <#T##String?#>, bundle: .main)
  }

}
