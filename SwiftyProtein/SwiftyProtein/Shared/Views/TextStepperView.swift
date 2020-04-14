import UIKit

@IBDesignable
class TextStepperView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var stepper: UIStepper!

  /******************** Callbacks ********************/

  var valueDidChanged: ((_ value: Int) -> Void)?

  /******************** Parameters ********************/

  @IBInspectable
  var titleTextFormat: String? {
    didSet { updateTitleLabel(value: Double(value)) }
  }

  @IBInspectable
  var value: Int {
    get { Int(stepper.value) }
    set {
      stepper.value = Double(newValue)
      updateTitleLabel(value: Double(value))
    }
  }

  @IBInspectable
  var minimum: Int {
    get { return Int(stepper.minimumValue) }
    set { stepper.minimumValue = Double(newValue) }
  }

  @IBInspectable
  var maximum: Int {
    get { return Int(stepper.maximumValue) }
    set { stepper.maximumValue = Double(newValue) }
  }

  @IBInspectable
  var step: Int {
    get { return Int(stepper.stepValue) }
    set { stepper.stepValue = Double(newValue) }
  }

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


  private func setup() {
    loadNib()
    setupView()

    contentView.frame = bounds
    addSubview(contentView)
  }

  private func setupView() {
    setupStepperView()
  }

  private func setupStepperView() {
  }

  private func updateTitleLabel(value: Double) {
    titleLabel.text = String(format: titleTextFormat ?? "%.2f", value)
  }

  //----------------------------------------------------------------------------
  // MARK: - Action
  //----------------------------------------------------------------------------

  @IBAction func valueDidChanged(_ sender: UIStepper) {
    updateTitleLabel(value: sender.value)
    valueDidChanged?(Int(sender.value))
  }

}

