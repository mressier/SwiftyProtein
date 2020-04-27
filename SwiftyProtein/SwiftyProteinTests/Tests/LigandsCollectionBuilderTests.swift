import XCTest
@testable import SwiftyProtein

class LigandsCollectionBuilderTests: XCTestCase {

  func testLigandsCollectionBuilder_buildSections() {
    let ligands = ["A", "AB", "B", "Z", "Q", "1"]
    let expectedSections = ["A", "B", "Q", "Z", "1"]

    // When
    let collection = LigandsCollectionBuilder.build(
      from: ligands,
      alphabeticSections: LigandsAppList.alphabetical
    )

    // Then
    XCTAssertEqual(collection.count, expectedSections.count)
    XCTAssertEqual(collection.map() { $0.section.title }, expectedSections)
  }

  func testLigandsCollectionBuilder_buildFavorites() {
    let ligands = ["A", "AB", "B", "Z", "Q", "1"]

    // When
    let collection = LigandsCollectionBuilder.buildFavorites(from: ligands)

    // Then
    XCTAssertEqual(collection.count, 1)
    XCTAssertEqual(collection[0].content.map() { $0.name }, ligands)
  }

  func testLigandsCollectionBuilder_buildColection() {
    let ligands = ["A", "AB", "B", "Z", "Q", "1"]
    let favs = ["A", "Q", "1"]
    let expectedSections = ["", "A", "B", "Q", "Z", "1"]

    // When
    let collection = LigandsCollectionBuilder.build(
      from: LigandsAppList(ligands: ligands, favorites: favs)
    )

    // Then
    XCTAssertEqual(collection.count, expectedSections.count)
    XCTAssertEqual(collection.map() { $0.section.title }, expectedSections)
    XCTAssertEqual(collection[0].content.map() { $0.name }, favs)
  }

}
