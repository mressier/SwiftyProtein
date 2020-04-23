import XCTest
@testable import SwiftyProtein

class PDBLigandConverter_ConectTest: XCTestCase {

  func testConect1() {
    let line = "CONECT   33    4"

    // When
    let connections = try? PDBLigandConverter.connections(from: line)

    // Then
    XCTAssertNoThrow(try PDBLigandConverter.connections(from: line))
    XCTAssertEqual(connections, PDBConnection(source: 33, linkedTo: [4]))
  }

  func testConect2() {
    let line = "CONECT   21   16   19   22   43"

    // When
    let connections = try? PDBLigandConverter.connections(from: line)

    // Then
    XCTAssertNoThrow(try PDBLigandConverter.connections(from: line))
    XCTAssertEqual(connections, PDBConnection(source: 21,
                                              linkedTo: [16, 19, 22, 43]))
  }

  func testConect_missingValue() {
    XCTAssertThrowsError(
      try PDBLigandConverter.connections(from: "CONECT   21")
    )
  }

  func testConect_missingValue2() {
    XCTAssertThrowsError(
      try PDBLigandConverter.connections(from: "CONECT  ")
    )
  }

  func testConect_invalidValue() {
    XCTAssertThrowsError(
      try PDBLigandConverter.connections(from: "CONECT   21   16   19   2a   43")
    )
  }
}