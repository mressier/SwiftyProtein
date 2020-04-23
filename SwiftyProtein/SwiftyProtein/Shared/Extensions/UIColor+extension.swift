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

  public convenience init(hex: String) {
    let r, g, b, a: CGFloat

    let hex = hex.uppercased()

    let start = hex.hasPrefix("#") ?
      hex.index(hex.startIndex, offsetBy: 1) : hex.startIndex
    let hexColor = String(hex[start...])

    if hexColor.count == 8 {
      let scanner = Scanner(string: hexColor)
      var hexNumber: UInt64 = 0

      if scanner.scanHexInt64(&hexNumber) {
        r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        a = CGFloat(hexNumber & 0x000000ff) / 255

        self.init(red: r, green: g, blue: b, alpha: a)
        return
      }
    } else {
      let scanner = Scanner(string: hexColor)
      var hexNumber: UInt64 = 0

      if scanner.scanHexInt64(&hexNumber) {
        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        b = CGFloat(hexNumber & 0x0000ff) / 255

        self.init(red: r, green: g, blue: b, alpha: 1.0)
        return
      }
    }

    self.init(cgColor: UIColor.black.cgColor)
  }
}

extension UIColor {
  static var darkRed = UIColor(hex: "#992200")
  static var darkViolet = UIColor(hex: "#6600bb")
  static var salmon = UIColor(hex: "#ffaa77")
  static var darkGreen = UIColor(hex: "#007700")
  static var darkOrange = UIColor(hex: "#dd7700")
}

