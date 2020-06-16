import XCTest
import SceneKit
@testable import SwiftyProtein

class Array_AtomNodeTests: XCTestCase {

  let ligandNode = SCNLigandNode()

  private lazy var sampleAtomNodes: [SCNAtomNode] = {
    return FakeLigands.sample.map() { SCNAtomNode(atom: $0) }
  }()

  private lazy var sampleHydrogenNodes: [SCNAtomNode] = {
    return FakeLigands.hydrogenSample.map() { SCNAtomNode(atom: $0) }
  }()

  //----------------------------------------------------------------------------
  // MARK: - Extract Atom Pairs
  //----------------------------------------------------------------------------

  func testAtomNodeArray_ExtractAtomPairsSample() {
    let atomNodes = sampleAtomNodes
    let expectedPairs = [
      PathBounds(start: atomNodes[0], end: atomNodes[1]),
      PathBounds(start: atomNodes[0], end: atomNodes[2]),
      PathBounds(start: atomNodes[0], end: atomNodes[4]),
      PathBounds(start: atomNodes[1], end: atomNodes[4]),
      PathBounds(start: atomNodes[1], end: atomNodes[5]),
      PathBounds(start: atomNodes[2], end: atomNodes[3]),
      PathBounds(start: atomNodes[3], end: atomNodes[4]),
      PathBounds(start: atomNodes[4], end: atomNodes[5]),
      PathBounds(start: atomNodes[4], end: atomNodes[6]),
      PathBounds(start: atomNodes[5], end: atomNodes[6]),
    ]

    // When
    let pairs = atomNodes.extractAtomPairs()

    // Then
    XCTAssertEqual(expectedPairs.count, pairs.count)

    for pair in expectedPairs {
      XCTAssertTrue(pairs.contains() {
        return $0.start == pair.start && $0.end == pair.end
      })
    }
  }

  func testExtractAtomPair_withHydrogen() {
    let atomNodes = sampleHydrogenNodes
    let expectedPairs = [
      PathBounds(start: atomNodes[0], end: atomNodes[1]),
      PathBounds(start: atomNodes[2], end: atomNodes[0])
    ]

    // When
    let pairs = atomNodes.extractAtomPairs()

    // Then
    XCTAssertEqual(expectedPairs.count, pairs.count)

    for pair in expectedPairs {
      XCTAssertTrue(pairs.contains() {
        return $0.start == pair.start && $0.end == pair.end
      })
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Get Area Covered
  //----------------------------------------------------------------------------

  func testAreaCovered_Sample() {
    let atomNodes = sampleAtomNodes
    let expectedArea =
      Area3D(min: SCNVector3(x: -1.231, y: -0.99, z: -7.421),
             max: SCNVector3(x: 1.740, y: 1.234, z: -4.304))

    // When
    let area = atomNodes.areaCovered

    // Then
    XCTAssertEqual(area.min.x, expectedArea.min.x, accuracy: 0.001)
    XCTAssertEqual(area.min.y, expectedArea.min.y, accuracy: 0.001)
    XCTAssertEqual(area.min.z, expectedArea.min.z, accuracy: 0.001)
    XCTAssertEqual(area.max.x, expectedArea.max.x, accuracy: 0.001)
    XCTAssertEqual(area.max.y, expectedArea.max.y, accuracy: 0.001)
    XCTAssertEqual(area.max.z, expectedArea.max.z, accuracy: 0.001)

  }
}
