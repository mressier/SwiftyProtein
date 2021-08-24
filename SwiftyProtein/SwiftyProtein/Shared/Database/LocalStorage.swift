//
//  LocalStorage.swift
//  SwiftyProtein
//
//  Created by Ressier Mathilde on 23/08/2021.
//  Copyright © 2021 Mathilde Ressier. All rights reserved.
//

import Foundation

class LocalStorage {

  static var shared: LocalStorage = LocalStorage(suiteName: "SwiftyProtein")

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  private let defaults: UserDefaults
  private let suiteName: String?

  public init(suiteName: String? = nil) {
    if let name = suiteName {
      self.defaults = UserDefaults(suiteName: name) ?? .standard
      self.suiteName = name
    } else {
      self.defaults = UserDefaults.standard
      self.suiteName = nil
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var favorites: [String] {
    get { return defaults.object(forKey: "favorites") as? [String] ?? [String]() }
    set { defaults.set(newValue, forKey: "favorites") }
  }

  func add(favorite: String) {
    favorites.append(favorite)
  }

  func remove(favorite: String) {
    favorites.removeAll(where: { $0 == favorite })
  }

  func isFavorite(value: String) -> Bool {
    return favorites.contains(value)
  }

  func removePersistentDomain() {
    if let name = suiteName {
      defaults.removePersistentDomain(forName: name)
    }
  }
}
