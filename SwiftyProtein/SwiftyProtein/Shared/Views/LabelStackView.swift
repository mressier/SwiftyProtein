import UIKit

@IBDesignable
class LabelStackView: UIStackView {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /********************  UI  ********************/

  @IBInspectable var textFont: UIFont?

  @IBInspectable var textColor: UIColor?

  /******************** Content ********************/

  @IBInspectable var texts: [String] = [] {
    didSet {
      if oldValue.count != texts.count {
        setupStackView(texts: texts)
      } else {
        updateStackView(texts: texts)
      }
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  private func setupStackView(texts: [String]) {
    self.removeArrangedSubviewsFromSuperview()

    self.addArrangedSubviews(
      numberOfSubviews: texts.count
    ) { index in
      let label = update(label: UILabel(), text: texts[index])
      return label
    }
  }

  private func updateStackView(texts: [String]) {
    self.subviews.enumerated().forEach() { (index, view) in
      guard let label = view as? UILabel else { return }
      update(label: label, text: texts[index])
    }
  }

  @discardableResult
  private func update(label: UILabel, text: String) -> UILabel {
    label.text = text
    label.font = textFont
    label.textColor = textColor
    return label
  }
}
//
//@IBDesignable
//class StackedLabelsView: UIView, NibInstanciable {
//
//  //----------------------------------------------------------------------------
//  // MARK: - Properties
//  //----------------------------------------------------------------------------
//
//  /******************** Outlet ********************/
//
//  @IBOutlet private var contentView: UIView!
//  @IBOutlet weak var labelsStackView: UIStackView!
//
//  /******************** Parameters ********************/
//
//  var texts: [String] = [] {
//    didSet {
//      if oldValue.count != texts.count {
//        setupStackView(texts: texts)
//      } else {
//        updateStackView(texts: texts)
//      }
//    }
//  }
//
//  var textFont: UIFont?
//
//  var defaultStackAxis: NSLayoutConstraint.Axis = .horizontal
//
//  var secondaryStackAxis: NSLayoutConstraint.Axis?
//
//  @IBInspectable var textColor: UIColor?
//
//  //----------------------------------------------------------------------------
//  // MARK: - Initialization
//  //----------------------------------------------------------------------------
//
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    setup()
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//    setup()
//  }
//
//  //----------------------------------------------------------------------------
//  // MARK: - Override
//  //----------------------------------------------------------------------------
//
//  override func traitCollectionDidChange(
//    _ previousTraitCollection: UITraitCollection?
//  ) {
//    super.traitCollectionDidChange(previousTraitCollection)
//    setupStackViewAxis(traitCollection: traitCollection)
//  }
//
//  //----------------------------------------------------------------------------
//  // MARK: - Setup
//  //----------------------------------------------------------------------------
//
//  private func setup() {
//    loadNib()
//    setupView()
//
//    contentView.frame = bounds
//    addSubview(contentView)
//  }
//
//  private func setupView() {
//    setupStackView(texts: texts)
//    setupStackViewAxis(traitCollection: traitCollection)
//  }
//
//  private func setupStackView(texts: [String]) {
//    labelsStackView.removeArrangedSubviewsFromSuperview()
//
//    labelsStackView.addArrangedSubviews(
//      numberOfSubviews: texts.count
//    ) { index in
//      let label = update(label: UILabel(), text: texts[index])
//      return label
//    }
//  }
//
//  private func setupStackViewAxis(traitCollection: UITraitCollection) {
//    if traitCollection.verticalSizeClass == .regular {
//      labelsStackView.axis = defaultStackAxis
//    } else {
//      labelsStackView.axis = secondaryStackAxis ?? defaultStackAxis
//    }
//  }
//
//  //----------------------------------------------------------------------------
//  // MARK: - Update
//  //----------------------------------------------------------------------------
//
//  private func updateStackView(texts: [String]) {
//    labelsStackView.subviews.enumerated().forEach() { (index, view) in
//      guard let label = view as? UILabel else { return }
//      update(label: label, text: texts[index])
//    }
//  }
//
//  @discardableResult
//  private func update(label: UILabel, text: String) -> UILabel {
//    label.text = text
//    label.font = textFont
//    label.textColor = textColor
//    return label
//  }
//
//}
