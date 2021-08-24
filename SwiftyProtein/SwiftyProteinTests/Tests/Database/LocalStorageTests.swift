//
//  LocalStorageTests.swift
//  SwiftyProteinTests
//
//  Created by Ressier Mathilde on 23/08/2021.
//  Copyright © 2021 Mathilde Ressier. All rights reserved.
//

import XCTest
@testable import SwiftyProtein

class LocalStorageTests: XCTestCase {

  private var storage = LocalStorage(suiteName: "tests")

  override func tearDown() {
    storage.removePersistentDomain()
  }

  //----------------------------------------------------------------------------
  // MARK: - Test Favorites
  //----------------------------------------------------------------------------

  func testFavorites() throws {
    XCTAssertTrue(storage.favorites.isEmpty)

    storage.add(favorite: "hello")
    XCTAssertEqual(storage.favorites, ["hello"])


    storage.add(favorite: "world")
    XCTAssertEqual(storage.favorites, ["hello", "world"])

    storage.remove(favorite: "hello")
    storage.remove(favorite: "test")
    XCTAssertEqual(storage.favorites, ["world"])
  }

}
