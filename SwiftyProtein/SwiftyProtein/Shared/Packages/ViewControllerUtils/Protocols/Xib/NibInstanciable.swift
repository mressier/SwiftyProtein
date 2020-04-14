//
//  NibFileOwnerLoadable.swift
//  Laboratory
//
//  Created by Laurent on 09/05/2019.
//  Copyright © 2019 Laurent. All rights reserved.
//

import UIKit

/*******************************************************************************
 * NibInstanciable
 *
 * Convenient protocol to loadNib in UIView classes.
 *
 ******************************************************************************/

public protocol NibInstanciable: class {
  func loadNib()
}

public extension NibInstanciable where Self: UIView {

  static var nibName: String { return String(describing: Self.self) }

  func loadNib() {
    let bundle = Bundle(for: type(of: self))
    let nibName = String(describing: Self.self)
    bundle.loadNibNamed(nibName, owner: self, options: nil)
  }

}
