import Foundation

extension Array where Element == String {

  func filter(startingWith string: String,
              ignoringCase: Bool) -> [String] {
    let compare = ignoringCase ? string.uppercased() : string

    return filter() { element in
      let elementToCompare = ignoringCase ? element.uppercased() : element
      return elementToCompare.starts(with: compare)
    }
  }

}
