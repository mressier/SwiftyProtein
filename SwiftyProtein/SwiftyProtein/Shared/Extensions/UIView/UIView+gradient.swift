import UIKit

extension UIView {

  @discardableResult
  func setGradient(leftColor: UIColor, rightColor: UIColor) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradientLayer.frame = self.bounds

    layer.insertSublayer(gradientLayer, at: 0)
    return gradientLayer
  }

  @discardableResult
  func setGradient(topColor: UIColor, bottomColor: UIColor) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0.0, 1.0]
    gradientLayer.frame = self.bounds

    layer.insertSublayer(gradientLayer, at: 0)
    return gradientLayer
  }
}
