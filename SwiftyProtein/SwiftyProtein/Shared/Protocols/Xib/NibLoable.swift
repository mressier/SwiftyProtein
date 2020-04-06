//
//  NibFileOwnerLoadable.swift
//  Laboratory
//
//  Created by Laurent on 09/05/2019.
//  Copyright © 2019 Laurent. All rights reserved.
//

import UIKit

/*******************************************************************************
 * NibLoadable
 *
 * Convenient protocol to loadNib in UIView classes.
 *
 ******************************************************************************/

public protocol NibLoadable: class {
  func loadNib()
}

public extension NibLoadable where Self: UIView {

  func loadNib() {
    let bundle = Bundle(for: type(of: self))
    let nibName = String(describing: Self.self)
    bundle.loadNibNamed(nibName, owner: self, options: nil)
  }

}
