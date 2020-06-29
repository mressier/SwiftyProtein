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
    title: "Sorry, this ligand doesn't seems to exist.",
    image: SPAssets.sadSmiley.image
  )

  static let ligandNotReadable = MessageView.Content(
    title: "Sorry, the informations of this ligand are not well formatted",
    image: SPAssets.sadSmiley.image
  )

  static let ligandDefaultError = MessageView.Content(
    title: "Sorry, an error happens on trying to download this ligand.",
    image: SPAssets.sadSmiley.image
  )
}

