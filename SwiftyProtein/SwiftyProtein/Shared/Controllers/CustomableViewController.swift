import UIKit

class CustomableViewController<Element: UIView>: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** UI ********************/

  var customView: Element?

  var constraints: ConstraintType = .edge

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override func viewDidLoad() {
    super.viewDidLoad()

    customView = Element()
    guard let subview = customView else { return }
    view.add(subview: subview, with: constraints)
  }
}
