//
//  LigandControlsView.swift
//  SwiftyProtein
//
//  Created by Ressier Mathilde on 24/08/2021.
//  Copyright © 2021 Mathilde Ressier. All rights reserved.
//

import UIKit

class LigandControlsView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Outlets
  //----------------------------------------------------------------------------

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var resetZoomButton: UIButton!
  @IBOutlet weak var showLabelsButton: UIButton!

  var didTouchResetZoom: (() -> Void)?
  var didTouchShowLabels: (() -> Void)?
  var didTouchHideLabels: (() -> Void)?

  private var isShowingLabels: Bool = false {
    didSet {
      if isShowingLabels {
        setupButtonBackgrounded(showLabelsButton)
        showLabelsButton.setTitle("Hide Labels", for: .normal)
      } else {
        setupButtonBordered(showLabelsButton)
        showLabelsButton.setTitle("Show Labels", for: .normal)
      }
    }
  }

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
  // MARK: - Actions
  //----------------------------------------------------------------------------

  @IBAction func didTouchResetZoomButton(_ sender: Any) {
    didTouchResetZoom?()
  }

  @IBAction func didTouchShowLabelsButton(_ sender: Any) {
    isShowingLabels = !isShowingLabels

    isShowingLabels ? didTouchShowLabels?() : didTouchHideLabels?()
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
    let zoomButton = UIImage(systemName: "minus.slash.plus")?.alwaysTemplate
    let labelButton = UIImage(systemName: "smallcircle.circle")?.alwaysTemplate

    resetZoomButton.setImage(zoomButton, for: .normal)
    setupButtonBordered(resetZoomButton)

    showLabelsButton.setImage(labelButton, for: .normal)
    setupButtonBordered(showLabelsButton)
  }

  private func setupButtonBordered(_ button: UIButton) {
    button.cornerRadius = 5.0

    button.tintColor = .swiftyBlueGreen
    button.borderWidth = 1.0
    button.borderColor = .swiftyBlueGreen
    button.backgroundColor = .white.withAlphaComponent(0.7)
  }

  private func setupButtonBackgrounded(_ button: UIButton) {
    button.cornerRadius = 5.0

    button.tintColor = .white
    button.backgroundColor = .swiftyBlueGreen
  }
}
