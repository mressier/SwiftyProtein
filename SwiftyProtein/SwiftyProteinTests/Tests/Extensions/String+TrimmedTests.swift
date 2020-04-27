import XCTest
@testable import SwiftyProtein

class String_TrimmedTests: XCTestCase {

  func testTrim_NothingToTrim() {
    XCTAssertEqual("hello world".trimmed(), "hello world")
    XCTAssertEqual("".trimmed(), "")
    XCTAssertEqual("h".trimmed(), "h")
    XCTAssertEqual("h i j".trimmed(), "h i j")
  }

  func testTrim_TrimStart() {
    XCTAssertEqual(" hello world".trimmed(), "hello world")
    XCTAssertEqual("     hello world".trimmed(), "hello world")
    XCTAssertEqual(" ".trimmed(), "")
    XCTAssertEqual(" h".trimmed(), "h")
    XCTAssertEqual(" h i j".trimmed(), "h i j")
  }

  func testTrim_TrimEnd() {
    XCTAssertEqual("hello world ".trimmed(), "hello world")
    XCTAssertEqual("hello world    ".trimmed(), "hello world")
    XCTAssertEqual("    ".trimmed(), "")
    XCTAssertEqual("h ".trimmed(), "h")
    XCTAssertEqual("h i j ".trimmed(), "h i j")
  }

  func testTrim_TrimBoth() {
    XCTAssertEqual("  hello world ".trimmed(), "hello world")
    XCTAssertEqual(" hello world    ".trimmed(), "hello world")
    XCTAssertEqual("    ".trimmed(), "")
    XCTAssertEqual("   h ".trimmed(), "h")
    XCTAssertEqual(" h i j ".trimmed(), "h i j")
  }
}
