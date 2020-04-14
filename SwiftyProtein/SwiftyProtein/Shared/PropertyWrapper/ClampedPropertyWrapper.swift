import Foundation

@propertyWrapper struct Clamped<Value: Comparable> {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var value: Value
  let min: Value
  let max: Value

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(wrappedValue: Value, min: Value, max: Value) {
    value = wrappedValue
    self.min = min
    self.max = max
    assert(value >= min && value <= max)
  }

  //----------------------------------------------------------------------------
  // MARK: - Wrapping
  //----------------------------------------------------------------------------

  var wrappedValue: Value {
    get { return value }
    set {
      if newValue < min {
        value = min
      } else if newValue > max {
        value = max
      } else {
        value = newValue
      }
    }
  }

}
