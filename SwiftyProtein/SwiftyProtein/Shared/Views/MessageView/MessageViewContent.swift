import UIKit

extension MessageView.Content {

  static let noInternet = MessageView.Content(
    title: "You seems to be offline !\nTurn on wifi or data and try again.",
    image: UIImage(
      systemName: "wifi.exclamationmark",
      withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle)
    )
  )

  static let ligandNotFound = MessageView.Content(
    title: "Sorry, cannot found the ligand !",
    image: SPAssets.sadSmiley.image
  )
}

