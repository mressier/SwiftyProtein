//
//  UIImageView+extension.swift
//  Melomind
//
//  Created by Mathilde on 02/05/2019.
//  Copyright © 2019 MyBrainTech. All rights reserved.
//

import UIKit

extension UIImageView {
  func setImageAlwaysTemplate(from newImage: UIImage?) {
    image = newImage?.alwaysTemplate
  }

  func setImageAlwaysTemplate(from asset: ImageAsset) {
    setImageAlwaysTemplate(from: asset.image)
  }

  func setImage(from asset: ImageAsset) {
    image = asset.image
  }
}
