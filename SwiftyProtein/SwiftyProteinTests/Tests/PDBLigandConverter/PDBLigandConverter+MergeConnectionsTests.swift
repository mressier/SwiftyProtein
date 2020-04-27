import XCTest
@testable import SwiftyProtein

class PDBLigandConverter_MergeConnectionsTests: XCTestCase {

  func testMergeConnections_Basic() {
    let connections = [
      PDBConnection(source: 0, linkedTo: [1, 2]),
      PDBConnection(source: 1, linkedTo: [0, 2]),
      PDBConnection(source: 2, linkedTo: [0, 1])
    ]

    // When
    let merged = connections.mergeSameSourceIndex()

    //Then
    XCTAssertEqual(merged, connections)
  }

  func testMergeConnections_All() {
    let connections = [
      PDBConnection(source: 0, linkedTo: [1, 2]),
      PDBConnection(source: 0, linkedTo: [3, 4]),
      PDBConnection(source: 0, linkedTo: [5, 6])
    ]

    // When
    let merged = connections.mergeSameSourceIndex()

    //Then
    XCTAssertEqual(merged, [
      PDBConnection(source: 0, linkedTo: [1, 2, 3, 4, 5, 6])
    ])
  }


  func testMergeConnections_Part() {
    let connections = [
      PDBConnection(source: 0, linkedTo: [1, 2]),
      PDBConnection(source: 1, linkedTo: [3, 4]),
      PDBConnection(source: 1, linkedTo: [5, 6]),
      PDBConnection(source: 2, linkedTo: [5, 6])
    ]

    // When
    let merged = connections.mergeSameSourceIndex()

    //Then
    XCTAssertEqual(merged, [
      PDBConnection(source: 0, linkedTo: [1, 2]),
      PDBConnection(source: 1, linkedTo: [3, 4, 5, 6]),
      PDBConnection(source: 2, linkedTo: [5, 6])
    ])
  }
}
