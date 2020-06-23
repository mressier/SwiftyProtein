import UIKit

class ScrollBarView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet private var contentView: UIView!
  @IBOutlet private weak var scrollContent: UIView!

  @IBOutlet weak var scrollImage: UIImageView!
  @IBOutlet weak var scrollLine: UIView!
  @IBOutlet weak var scrollLabel: UILabel!

  /******************** Callback ********************/

  var didScrollTo: ((_ percent: CGFloat) -> Void)?
  var didBeginScroll: (() -> Void)?
  var didEndScroll: (() -> Void)?

  var isScrolling: Bool = false

  /******************** View tools ********************/

  var usableHeight: CGFloat {
    return scrollLine.bounds.height - scrollContentHeight
  }

  var scrollContentHeight: CGFloat { return scrollContent.frame.height }

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
      self.scrollContent.alpha = 1.0
      self.scrollLine.alpha = 1.0
    }
  }

  func hideScrollBar() {
    UIView.animate(withDuration: 0.3) {
      self.scrollLine.alpha = 0.0
      self.scrollContent.alpha = 0.0
    }
  }

  //----------------------------------------------------------------------------
  // MARK: - Pan Gesture Handler
  //----------------------------------------------------------------------------

  @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
    handleScrollingState(sender)
    handleTranslation(sender)

    /// Calcul percent of progression in the view
    let percent = scrollContent.frame.origin.y / usableHeight
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
    sender.setTranslation(.zero, in: contentView)

    guard let scrollContent = scrollContent else { return }

    let yTranslation = scrollContent.frame.origin.y + translation.y
    scrollSliderTo(yOffset: yTranslation)
  }

  private func scrollSliderTo(yOffset: CGFloat) {
    let y = yOffset.clamped(min: 0, max: usableHeight)
    scrollContent.frame.origin.y = y
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
    setupScrollContent()
    setupPanGesture()
  }

  private func setupScrollImage() {
    scrollImage.tintColor = .secondarySystemBackground
    scrollImage.borderColor = .systemGray3
    scrollImage.borderWidth = 1.0
    scrollImage.setAsCircle()
  }

  private func setupScrollLine() {
    scrollLine.backgroundColor = .systemGray3
    scrollLine.alpha = 0.0
  }

  private func setupScrollLabel() {
    scrollLabel.text = nil
    scrollLabel.textColor = .systemGray3
    scrollLabel.font = UIFont.systemFont(ofSize: 12.0)
  }

  private func setupScrollContent() {
    scrollContent.alpha = 0.0
  }

  private func setupPanGesture() {
    let selector = #selector(self.handlePan(_:))
    let tap = UIPanGestureRecognizer(target: self, action: selector)
    contentView.addGestureRecognizer(tap)
    contentView.isUserInteractionEnabled = true
  }

}

