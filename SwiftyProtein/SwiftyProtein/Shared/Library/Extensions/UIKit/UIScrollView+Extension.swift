//
//  UIScrollView+Extension.swift
//  Melomind.iOS-V2
//
//  Created by facileit on 01/02/2018.
//  Copyright © 2018 MyBrainTech. All rights reserved.
//

import UIKit

extension UIScrollView {

    @objc func onViewTouched() {
        endEditing(true)
    }

    var isOnLeft: Bool {
        return contentOffset.x <= horizontalOffsetForLeft
    }
    var isOnRight: Bool {
        return contentOffset.x >= horizontalOffsetForRight
    }
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    var horizontalOffsetForLeft: CGFloat {
        let leftInset = contentInset.left
        return -leftInset
    }
    var horizontalOffsetForRight: CGFloat {
        let scrollViewWidth = bounds.width
        let scrollContentSizeWidth = contentSize.width
        let rightInset = contentInset.right
        let scrollViewRightOffset =
          scrollContentSizeWidth + rightInset - scrollViewWidth
        return scrollViewRightOffset
    }

    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset =
          scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }

    var visibleCenter: CGPoint {
        return CGPoint(x: center.x + contentOffset.x,
                       y: center.y + contentOffset.y)
    }

  func scrollTo(view: UIView?) {
    guard let view = view, let superview = view.superview else { return }

    var offset = superview.frame.origin
    offset.y += view.frame.origin.y
    scrollTo(offset: offset)
  }

  func scrollTo(offset: CGPoint) {
    guard contentSize != CGSize.zero else { return }
    guard offset.y > bounds.height * 0.40 else {
      UIView.animate(withDuration: 0.4,
                     animations: { self.bounds.origin.y = 0 })
      return
    }

    let originY = offset.y - frame.height * 0.50
    UIView.animate(withDuration: 0.4,
                   animations: { self.bounds.origin.y = originY })
  }

}
