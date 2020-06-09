import UIKit

/*******************************************************************************
 * LigandNotFoundView
 *
 * A view with error message for LigandNotFound
 *
 ******************************************************************************/
@IBDesignable
class ErrorMessageView: MessageView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    self.messageText = "Sorry, cannot found the ligand !"
    self.messageImage = SPAssets.sadSmiley.image
  }
}
