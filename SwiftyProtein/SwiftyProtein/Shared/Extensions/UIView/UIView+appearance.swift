//
//  UIView+Extension.swift
//  Melomind.iOS-V2
//
//  Created by facileit on 24/01/2018.
//  Copyright © 2018 MyBrainTech. All rights reserved.
//

import UIKit

extension UIView {
  // AddSubview and addLayout

  func setAsCircle() {
    setAsCircle(withBounds: min(bounds.width, bounds.height))
  }

  func setAsCircle(withBounds bounds: CGFloat) {
    layer.cornerRadius = bounds / 2
    clipsToBounds = true
  }

  /******************** Border ********************/

  var borderColor: UIColor? {
    get {
      guard let color = layer.borderColor else { return nil }
      return UIColor(cgColor: color)
    }
    set { layer.borderColor = newValue?.cgColor }
  }

  var borderWidth: CGFloat {
    get { return layer.borderWidth }
    set { layer.borderWidth = newValue }
  }

  /******************** Corner ********************/

  var cornerRadius: Double {
    get { return Double(layer.cornerRadius) }
    set { layer.cornerRadius = CGFloat(newValue) }
  }
}
