import UIKit

class ScrollBarView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private var contentView: UIView!
  @IBOutlet private weak var scrollContentView: UIView!

  @IBOutlet weak var scrollImage: UIImageView!
  @IBOutlet weak var scrollLine: UIView!
  @IBOutlet weak var scrollLabel: ScrollBarLabelView!

  /******************** Callback ********************/

  var didScrollTo: ((_ percent: CGFloat) -> Void)?
  var didBeginScroll: (() -> Void)?
  var didEndScroll: (() -> Void)?

  var isScrolling: Bool = false

  /******************** View tools ********************/

  var usableHeight: CGFloat {
    return scrollContentView.bounds.height - imageHeight
  }

  var imageHeight: CGFloat { return scrollImage.frame.height }

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  //----------------------------------------------------------------------------
  // MARK: - Scroll
  //----------------------------------------------------------------------------

  func scroll(to percentOfView: CGFloat) {
    let yOffset = usableHeight * percentOfView
    scrollSliderTo(yOffset: yOffset)
  }

  func showScrollBar() {
    UIView.animate(withDuration: 0.3) {
      self.scrollImage.alpha = 1.0
      self.scrollLine.alpha = 1.0
      self.scrollLabel.alpha = 1.0
    }
  }

  func hideScrollBar() {
    UIView.animate(withDuration: 0.3) {
      self.scrollImage.alpha = 0.0
      self.scrollLine.alpha = 0.0
      self.scrollLabel.alpha = 0.0
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Pan Gesture Handler
  //----------------------------------------------------------------------------

  @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
    handleScrollingState(sender)
    handleTranslation(sender)

    /// Calcul percent of progression in the view
    let percent = scrollImage.frame.origin.y / usableHeight
    didScrollTo?(percent)
  }

  private func handleScrollingState(_ sender: UIPanGestureRecognizer) {
    switch sender.state {
    case .began:
      isScrolling = true
      didBeginScroll?()
    case .ended:
      isScrolling = false
      didEndScroll?()
    default: return
    }
  }

  private func handleTranslation(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: contentView)

    guard let imageView = scrollImage else { return }

    let yTranslation = imageView.frame.origin.y + translation.y
    scrollSliderTo(yOffset: yTranslation)

    sender.setTranslation(.zero, in: contentView)
  }

  private func scrollSliderTo(yOffset: CGFloat) {
    let y = yOffset.clamped(min: 0, max: usableHeight)
    scrollImage.frame.origin.y = y
    scrollLabel.center.y = scrollImage.center.y
  }

  //----------------------------------------------------------------------------
  // MARK: - Setup
  //----------------------------------------------------------------------------

  private func setup() {
    loadNib()
    setupView()

    contentView.frame = bounds
    addSubview(contentView)
  }

  private func setupView() {
    setupScrollLine()
    setupScrollImage()
    setupScrollLabel()
    setupPanGesture()
  }

  private func setupScrollImage() {
    scrollImage.image = SPAssets.scrollArrow.image.alwaysTemplate
    scrollImage.tintColor = .swiftyBlue
    scrollImage.alpha = 0.0
  }

  private func setupScrollLine() {
    scrollLine.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
    scrollLine.alpha = 0.0
  }

  private func setupScrollLabel() {
    scrollLabel.alpha = 0.0
    scrollLabel.text = nil
  }

  private func setupPanGesture() {
    let selector = #selector(self.handlePan(_:))
    let tap = UIPanGestureRecognizer(target: self, action: selector)
    contentView.addGestureRecognizer(tap)
    contentView.isUserInteractionEnabled = true
  }

}

