import XCTest
@testable import SwiftyProtein

class PDBLigandProvider_buildURLTests: XCTestCase {

  func testBuildURL() {
    let url = PDBLigandProvider.buildURL(forLigand: "ATP")

    XCTAssertEqual(url,
                   "http://ligand-expo.rcsb.org/reports/A/ATP/ATP_ideal.pdb")
  }

  func testBuildURL2() {
    let url = PDBLigandProvider.buildURL(forLigand: "BU")

    XCTAssertEqual(url,
                   "http://ligand-expo.rcsb.org/reports/B/BU/BU_ideal.pdb")
  }

}
