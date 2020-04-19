import UIKit

extension String {

  //----------------------------------------------------------------------------
  // MARK: - Regex
  //----------------------------------------------------------------------------

  func matches(regex: String,
               options: NSRegularExpression.Options = []) -> [String] {
    guard let regex = try? NSRegularExpression(pattern: regex,
                                               options: options) else {
                                                return []
    }

    let string = self as NSString
    let range = NSRange(location: 0, length: self.count)
    let matches = regex.matches(in: self, range: range)
    return matches.map() { string.substring(with: $0.range) }
  }

  func substringMatches(regex: String,
                        options: NSRegularExpression.Options = []) -> [[String]] {
    guard let regex = try? NSRegularExpression(pattern: regex,
                                               options: options) else {
                                                return []
    }

    let string = self as NSString
    let range = NSRange(location: 0, length: self.count)
    let matches = regex.matches(in: self, range: range)

    return matches.map() { match in
      var submatches = [String]()

      for i in 0 ..< match.numberOfRanges {
        let range = match.range(at: i)
        guard range.location != NSNotFound else { break }

        submatches.append(string.substring(with: range))
      }

      return submatches
    }
  }

  func contains(regex: String,
                options: NSRegularExpression.Options = []) -> Bool {
    return matches(regex: regex, options: options).count > 0
  }

  func contains(_ characterSet: CharacterSet) -> Bool {
    return self.rangeOfCharacter(from: characterSet) != nil
  }

  func firstMatch(regex: String,
                  options: NSRegularExpression.Options = []) -> String? {
    return matches(regex: regex, options: options).first
  }

  //----------------------------------------------------------------------------
  // MARK: - Trim
  //----------------------------------------------------------------------------

  func trimmed() -> String {
    guard let firstNotSpace = self.firstIndex(where: { !$0.isWhitespace }),
      let lastNotSpace = self.lastIndex(where: { !$0.isWhitespace }) else {
        return ""
    }

    return String(self[firstNotSpace ... lastNotSpace])
  }
}
