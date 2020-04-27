import XCTest
@testable import SwiftyProtein

class PDBLigandConverter_AtomTest: XCTestCase {

  func testAtom1() {
    let atom = "ATOM      1  PG  ATP A   1       1.200  -0.226  -6.850  1.00 10.00           P"

    let pdb = PDBAtom(index: 1,
                      atomName: "PG",
                      alternateLocationIndicator: "",
                      residueName: "ATP",
                      chainIdentifier: "A",
                      residueSequenceNumber: 1,
                      residueInsertionCode: "",
                      x: 1.2,
                      y: -0.226,
                      z: -6.85,
                      occupancy: 1.0,
                      temperatureFactor: 10.0,
                      symbol: "P",
                      charge: "",
                      linkedAtomIndex: [])

    // When
    let convertedAtom = try? PDBLigandConverter.atom(from: atom)

    // Then
    XCTAssertNoThrow(try PDBLigandConverter.atom(from: atom))
    XCTAssertEqual(pdb, convertedAtom)
  }

  func testAtom2() {
    let atom = "ATOM     32 HOG2 ATP A   1       2.100  -0.546  -8.725  1.00 10.00           H"

    let pdb = PDBAtom(index: 32,
                      atomName: "HOG2",
                      alternateLocationIndicator: "",
                      residueName: "ATP",
                      chainIdentifier: "A",
                      residueSequenceNumber: 1,
                      residueInsertionCode: "",
                      x: 2.1,
                      y: -0.546,
                      z: -8.725,
                      occupancy: 1.0,
                      temperatureFactor: 10.0,
                      symbol: "H",
                      charge: "",
                      linkedAtomIndex: [])

    // When
    let convertedAtom = try? PDBLigandConverter.atom(from: atom)

    // Then
    XCTAssertNoThrow(try PDBLigandConverter.atom(from: atom))
    XCTAssertEqual(pdb, convertedAtom)
  }

  func testAtom_Empty() {
    // Then
    XCTAssertThrowsError(try PDBLigandConverter.atom(from: ""))
  }

  func testAtom_OnlyAtom() {
    // Then
    XCTAssertThrowsError(try PDBLigandConverter.atom(from: "ATOM"))
  }

  func testAtom_MissingLocation() {
    // Then
    XCTAssertThrowsError(try PDBLigandConverter.atom(from: "ATOM     32 HOG2 ATP A   1       1.00 10.00           H"))
  }
}
