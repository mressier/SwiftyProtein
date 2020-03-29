import XCTest
import SceneKit
@testable import SwiftyProtein

class AtomNodeArrayTests: XCTestCase {

  let sampleAtomNodes =
    SCNNode().createAtomNodes(forAtoms: FakeLigands.sample)

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
}
