import XCTest
@testable import SwiftyProtein

class PDBLigandConverter_InputTypeTest: XCTestCase {

    func testAtomInput() {
      XCTAssertTrue(PDBLigandConverter.isAtomInput(string: "ATOM"))
      XCTAssertTrue(PDBLigandConverter.isAtomInput(string: "ATOM123"))
      XCTAssertTrue(PDBLigandConverter.isAtomInput(string: "ATOM   123"))
      XCTAssertTrue(PDBLigandConverter.isAtomInput(string: "ATOMM"))

      XCTAssertFalse(PDBLigandConverter.isAtomInput(string: " ATOM"))
      XCTAssertFalse(PDBLigandConverter.isAtomInput(string: "ATOOM"))
    }


  func testHetatmInput() {
    XCTAssertTrue(PDBLigandConverter.isHetatmInput(string: "HETATM"))
    XCTAssertTrue(PDBLigandConverter.isHetatmInput(string: "HETATM123"))
    XCTAssertTrue(PDBLigandConverter.isHetatmInput(string: "HETATMM"))

    XCTAssertFalse(PDBLigandConverter.isHetatmInput(string: " HETATM"))
    XCTAssertFalse(PDBLigandConverter.isHetatmInput(string: "HETAATM"))
  }

  func testConnectInput() {
    XCTAssertTrue(PDBLigandConverter.isConnectInput(string: "CONECT"))
    XCTAssertTrue(PDBLigandConverter.isConnectInput(string: "CONECT123"))
    XCTAssertTrue(PDBLigandConverter.isConnectInput(string: "CONECTT"))

    XCTAssertFalse(PDBLigandConverter.isConnectInput(string: " CONECT"))
    XCTAssertFalse(PDBLigandConverter.isConnectInput(string: "CONECQT"))
  }

}
