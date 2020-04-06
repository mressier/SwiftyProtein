//
//  CorneredView.swift
//  HomePageLaboratory
//
//  Created by Mathilde Ressier on 05/08/2019.
//  Copyright © 2019 Laurent. All rights reserved.
//

import UIKit

@IBDesignable
class CorneredView: UIView {

  @IBInspectable var cornerRadius: CGFloat {
    get { return self.layer.cornerRadius }
    set { self.layer.cornerRadius = newValue }
  }

}
