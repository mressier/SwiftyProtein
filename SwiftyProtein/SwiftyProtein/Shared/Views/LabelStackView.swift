import UIKit

@IBDesignable
class LabelStackView: UIStackView {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /********************  UI  ********************/

  @IBInspectable var textFont: UIFont? {
    didSet { updateStackView(texts: texts) }
  }

  @IBInspectable var textColor: UIColor? {
    didSet { updateStackView(texts: texts) }
  }

  var textAlignment: NSTextAlignment? {
    didSet { updateStackView(texts: texts) }
  }

  var lineBreakMode: NSLineBreakMode? {
    didSet { updateStackView(texts: texts) }
  }

  var numberOfLines: Int = 1 {
    didSet { updateStackView(texts: texts) }
  }

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
    label.textAlignment = textAlignment ?? .left
    label.lineBreakMode = lineBreakMode ?? .byTruncatingTail
    label.numberOfLines = numberOfLines
    return label
  }
}
