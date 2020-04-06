//
//  UIStackView+extension.swift
//  Melomind
//
//  Created by Mathilde Ressier on 27/08/2019.
//  Copyright © 2019 MyBrainTech. All rights reserved.
//

import UIKit

extension UIStackView {
  /// Remove view from arranged subviews array and from the stack subviews
  /// so it will not longer be managed by the stack view and will disappear
  /// from the view.
  func removeArrangedSubviewsFromSuperview() {
    for view in arrangedSubviews {
      removeArrangedSubview(view)
      view.removeFromSuperview()
    }
  }

  func addArrangedSubviews<T: UIView>(numberOfSubviews: Int,
                                      create: ((_ index: Int) -> T)) {
    for i in 0 ..< numberOfSubviews {
      let element = create(i)
      addArrangedSubview(element)
    }
  }
}
