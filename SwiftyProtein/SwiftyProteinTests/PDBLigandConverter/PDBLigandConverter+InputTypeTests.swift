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

  func testConectInput() {
    XCTAssertTrue(PDBLigandConverter.isConectInput(string: "CONECT"))
    XCTAssertTrue(PDBLigandConverter.isConectInput(string: "CONECT123"))
    XCTAssertTrue(PDBLigandConverter.isConectInput(string: "CONECTT"))

    XCTAssertFalse(PDBLigandConverter.isConectInput(string: " CONECT"))
    XCTAssertFalse(PDBLigandConverter.isConectInput(string: "CONECQT"))
  }

}
