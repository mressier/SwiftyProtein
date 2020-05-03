import Foundation

extension Array where Element: Comparable {

  /// Return the lowest element of the array
  var lowest: Element? {
    return reduce(nil) { result, element in
      guard let result = result else { return element }
      return element < result ? element : result
    }
  }

  /// Return the highest element of the array
  var highest: Element? {
    return reduce(nil) { result, element in
      guard let result = result else { return element }
      return element > result ? element : result
    }
  }
}
