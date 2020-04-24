import Foundation

extension Array {

  /// Get next index in array, starting after the given index, which validate the closure,
  /// or nil if nothing is found.
  func nextIndex(after startIndex: Int,
                 where closure: @escaping ((Element) -> Bool)) -> Int? {
    var index = startIndex

    while index != endIndex {
      if closure(self[index]) { return index }
      index = self.index(after: index)
    }

    return nil
  }
}
