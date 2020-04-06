import UIKit

class ChainedTextFields {

  /// Text fields to chain
  let textFields: [UITextField]

  //----------------------------------------------------------------------------
  // MARK: - Initialize
  //----------------------------------------------------------------------------

  /// Create a chain of text fields.
  /// - Parameter textFields: Fields to chain, in the expected order to jump
  /// (once 1st is done, jump the 2nd, then to the 3rd, ...)
  init(textFields: [UITextField], delegate: UITextFieldDelegate? = nil) {
    self.textFields = textFields
    setup(textFields: textFields, delegate: delegate)
  }

  private func setup(textFields: [UITextField],
                     delegate: UITextFieldDelegate? = nil) {
    let lastIndex = textFields.count - 1
    for (index, textField) in textFields.enumerated() {
      textField.tag = index
      textField.returnKeyType = index == lastIndex ? .done : .next

      if let delegate = delegate {
        textField.delegate = delegate
      }
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Text field selection
  //----------------------------------------------------------------------------

  @discardableResult
  func selectNextTextField(currentTextField: UITextField) -> UITextField? {
    let nextTag = currentTextField.tag + 1
    guard let nextField = textFields.first(where: { $0.tag == nextTag }) else {
      currentTextField.resignFirstResponder()
      return nil
    }
    nextField.becomeFirstResponder()
    return nextField
  }
}
