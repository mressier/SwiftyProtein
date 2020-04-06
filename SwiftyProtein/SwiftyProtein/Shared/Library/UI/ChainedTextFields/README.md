#  ChainedTextField

## How to use it

```swift

// Outlet

@IBOutlet private var textFields: [UITextField]!

// UI tools

private var chainedTextFields: ChainedTextFields!

// Initialization

override func viewDidLoad(animated: Bool) {
  super.viewDidLoad(animated: animated)
  
  chainedTextFields = ChainedTextFields(
    textFields: textFields,
    delegate: self
  )
}

// ...

extension <#MyViewController#>: UITextFieldDelegate {

func textFieldShouldReturn(_ textField: UITextField) -> Bool {
  chainedTextFields.selectNextTextField(currentTextField: textField)
  }
  
}
```
