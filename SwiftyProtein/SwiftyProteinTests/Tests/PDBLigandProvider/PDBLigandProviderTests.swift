import XCTest
@testable import SwiftyProtein

class PDBLigandProviderTests: XCTestCase {

  func testLigandProvider() {
    let ligand = "ATP"
    let completeExpectation = expectation(description: "Complete")

    PDBLigandProvider.shared.getLigand(ligand) {
      result in
      print (result)
      completeExpectation.fulfill()
    }

    wait(for: [completeExpectation], timeout: 10.0)
  }

}
