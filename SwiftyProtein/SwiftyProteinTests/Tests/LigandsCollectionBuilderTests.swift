import XCTest
@testable import SwiftyProtein

class LigandsCollectionBuilderTests: XCTestCase {

  //----------------------------------------------------------------------------
  // MARK: - Section
  //----------------------------------------------------------------------------

  func testLigandsCollectionBuilder_buildSections() {
    let ligands = ["A", "AB", "B", "Z", "Q", "1"]
    let expectedSections = ["A", "B", "Q", "Z", "1"]

    // When
    let collection = LigandsCollectionBuilder.buildList(
      from: ligands,
      alphabeticSections: LigandsAppList.alphabetical
    )

    // Then
    XCTAssertEqual(collection.count, expectedSections.count)
    XCTAssertEqual(collection.map() { $0.section.title }, expectedSections)
  }

  //----------------------------------------------------------------------------
  // MARK: - Favorites
  //----------------------------------------------------------------------------

  func testLigandsCollectionBuilder_buildFavorites() {
    let ligands = ["A", "AB", "B", "Z", "Q", "1"]

    // When
    let collection = LigandsCollectionBuilder.buildFavorites(from: ligands)

    // Then
    XCTAssertEqual(collection.count, 1)
    XCTAssertEqual(collection[0].content.map() { $0.name }, ligands)
  }

  func testLigandsCollectionBuilder_buildFavoritesWithNoFavs() {
    let ligands = [String]()

    // When
    let collection = LigandsCollectionBuilder.buildFavorites(from: ligands)

    // Then
    XCTAssertEqual(collection.count, 0)
  }


  //----------------------------------------------------------------------------
  // MARK: - Collection
  //----------------------------------------------------------------------------

  func testLigandsCollectionBuilder_buildCollection() {
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

  func testLigandsCollectionBuilder_buildCollectionWithoutFavs() {
    let ligands = ["A", "AB", "B", "Z", "Q", "1"]
    let favs = [String]()
    let expectedSections = ["A", "B", "Q", "Z", "1"]

    // When
    let collection = LigandsCollectionBuilder.build(
      from: LigandsAppList(ligands: ligands, favorites: favs)
    )

    // Then
    XCTAssertEqual(collection.count, expectedSections.count)
    XCTAssertEqual(collection.map() { $0.section.title }, expectedSections)
  }

  func testLigandsCollectionBuilder_buildCollectionWithFavs() {
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

    XCTAssertEqual(collection[1].content.first?.name, "A")
    XCTAssertEqual(collection[1].content.first?.isFavorite, true)
  }
}
