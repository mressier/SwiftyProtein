//
//  UIColor+Extension.swift
//  Melomind.iOS-V2
//
//  Created by facileit on 22/01/2018.
//  Copyright © 2018 MyBrainTech. All rights reserved.
//

import UIKit

extension UIColor {

  convenience init(redI: Int, greenI: Int, blueI: Int, alphaI: Int) {

    let currRed       = (redI > 0) ? (CGFloat(redI) / 255) : 0.0
    let currGreen     = (greenI > 0) ? (CGFloat(greenI) / 255) : 0.0
    let currBlue      = (blueI > 0) ? (CGFloat(blueI) / 255) : 0.0
    let currAlpha     = (alphaI > 0) ? (CGFloat(alphaI) / 100) : 0.0

    self.init(red: currRed,
              green: currGreen,
              blue: currBlue,
              alpha: currAlpha)
  }
}
