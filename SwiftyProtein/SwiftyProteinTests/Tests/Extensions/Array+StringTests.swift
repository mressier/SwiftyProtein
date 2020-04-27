import XCTest
@testable import SwiftyProtein

class Array_StringTests: XCTestCase {

  //----------------------------------------------------------------------------
  // MARK: - filter(startingWith)
  //----------------------------------------------------------------------------

  func test_filterStartingWith_basics() {
    let array = ["A", "B", "C", "a", "b", "c"]

    XCTAssertEqual(array.filter(startingWith: "A", ignoringCase: false), ["A"])
    XCTAssertEqual(array.filter(startingWith: "A", ignoringCase: true), ["A", "a"])
    XCTAssertEqual(array.filter(startingWith: "a", ignoringCase: true), ["A", "a"])

    XCTAssertEqual(["A"].filter(startingWith: "a", ignoringCase: true), ["A"])
    XCTAssertEqual(["B"].filter(startingWith: "a", ignoringCase: true), [])
    XCTAssertEqual([""].filter(startingWith: "a", ignoringCase: true), [])
    XCTAssertEqual([""].filter(startingWith: "", ignoringCase: true), [""])
  }

  func test_filterStartingWith_multiLetter() {
    let array = ["Abc", "Ba", "Ca", "abc", "bc", "cba"]

    XCTAssertEqual(array.filter(startingWith: "A", ignoringCase: false), ["Abc"])
    XCTAssertEqual(array.filter(startingWith: "Abc", ignoringCase: false), ["Abc"])

    XCTAssertEqual(array.filter(startingWith: "A", ignoringCase: true), ["Abc", "abc"])
    XCTAssertEqual(array.filter(startingWith: "AB", ignoringCase: true), ["Abc", "abc"])
    XCTAssertEqual(array.filter(startingWith: "a", ignoringCase: true), ["Abc", "abc"])

    XCTAssertEqual(["ABC"].filter(startingWith: "a", ignoringCase: true), ["ABC"])
    XCTAssertEqual(["BAC"].filter(startingWith: "a", ignoringCase: true), [])

    XCTAssertEqual(["AB"].filter(startingWith: "a", ignoringCase: false), [])
    XCTAssertEqual(["aBc"].filter(startingWith: "ab", ignoringCase: false), [])
  }
}
