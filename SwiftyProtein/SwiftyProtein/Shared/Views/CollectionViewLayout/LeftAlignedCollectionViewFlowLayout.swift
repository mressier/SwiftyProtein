import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

  override func layoutAttributesForElements(
    in rect: CGRect
  ) -> [UICollectionViewLayoutAttributes]? {
    guard let attributes = super.layoutAttributesForElements(in: rect) else {
      return nil
    }

    var newLayoutAttributes = [UICollectionViewLayoutAttributes]()
    var leftMargin = sectionInset.left
    var maxY: CGFloat = -1.0

    attributes.forEach { layoutAttribute in
      guard let attribute =
        layoutAttribute.copy() as? UICollectionViewLayoutAttributes else {
          return
      }

      newLayoutAttributes.append(attribute)

      guard attribute.representedElementIsCell else { return }

      if attribute.frame.origin.y >= maxY {
        leftMargin = sectionInset.left
      }

      attribute.frame.origin.x = leftMargin

      leftMargin += attribute.frame.width + minimumInteritemSpacing
      maxY = max(attribute.frame.maxY , maxY)
    }

    return newLayoutAttributes
  }
}

//==============================================================================
// MARK: - UICollectionViewLayoutAttributes
//==============================================================================

extension UICollectionViewLayoutAttributes {

  var representedElementIsSectionHeader: Bool {
    return representedElementKind == UICollectionView.elementKindSectionHeader
  }

  var representedElementIsSectionFooter: Bool {
    return representedElementKind == UICollectionView.elementKindSectionFooter
  }

  var representedElementIsCell: Bool {
    return representedElementIsSectionHeader == false
      && representedElementIsSectionFooter == false
  }
}
