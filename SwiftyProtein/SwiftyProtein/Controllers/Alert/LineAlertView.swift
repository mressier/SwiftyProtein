import UIKit

class LineAlertView: PaddedLabel {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Parameters ********************/

  var alertType: AlertViewType = .default {
    didSet { setupView(with: alertType) }
  }

  var message: String? 

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func hide() {
    globalInset = 0.0
    text = ""
  }

  func show(message: String? = nil, alertType: AlertViewType? = nil) {
    globalInset = 3.0
    text = message ?? self.message
    setupView(with: alertType ?? self.alertType)
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    setupLabel()
    setupView(with: alertType)
  }

  private func setupLabel() {
    globalInset = 5.0
    textAlignment = .center
    font = .systemFont(ofSize: 12.0)
  }

  private func setupView(with alertType: AlertViewType) {
    backgroundColor = alertType.backgroundColor
    textColor = alertType.labelColor
  }

}

