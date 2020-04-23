import XCTest
@testable import SwiftyProtein

class PDBLigandProvider_buildURLTests: XCTestCase {

  func testBuildURL() {
    let url = URLBuilder.build(forLigand: "ATP",
                               urlPrefix: "",
                               urlSuffix: "")

    XCTAssertEqual(url, "A/ATP/ATP")
  }

  func testBuildURL2() {

    let url = URLBuilder.build(forLigand: "BU",
                               urlPrefix: "",
                               urlSuffix: "")

    XCTAssertEqual(url, "B/BU/BU")
  }

}
