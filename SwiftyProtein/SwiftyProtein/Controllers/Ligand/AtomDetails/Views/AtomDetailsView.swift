import UIKit

struct AtomDetails {
  var atom: PDBLightAtom
  var ligand: PDBLightLigand
}

@IBDesignable
class AtomDetailsView: UIView, NibInstanciable {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  /******************** Outlet ********************/

  @IBOutlet var contentView: UIView!
  @IBOutlet weak var symbolLabel: UILabel!
  @IBOutlet weak var atomNameLabel: UILabel!
  @IBOutlet weak var coordinatesView: AtomCoordinatesView!
  @IBOutlet weak var usefullInformationsView: AtomDetailsInformationsView!

  /******************** Parameter ********************/

  var atomDetails: AtomDetails? {
    didSet { update(with: atomDetails) }
  }

  //----------------------------------------------------------------------------
  // MARK: - View Life Cycle
  //----------------------------------------------------------------------------

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    loadNib()
    setupView()

    contentView.frame = bounds
    addSubview(contentView)
  }

  private func setupView() {
    setupLabelText()
    setupInformationsLabel()
  }

  private func setupLabelText() {
    symbolLabel.text = "-"
    atomNameLabel.text = "----"
  }

  private func setupInformationsLabel() {
    usefullInformationsView.informationsStackView.numberOfLines = 0
    usefullInformationsView.informationsStackView.lineBreakMode = .byTruncatingTail
    usefullInformationsView.informations = [
      "---",
      "---",
      "---"
    ]
  }

  //----------------------------------------------------------------------------
  // MARK: - Update
  //----------------------------------------------------------------------------

  private func update(with atomDetails: AtomDetails?) {
    let atom = atomDetails?.atom
    let symbol = atom?.symbol ?? "-"
    let moreAtomDetails = AtomsList.atomsBySymbol[symbol]
    let atomName = moreAtomDetails?.name.capitalized
    let atomicNumber = moreAtomDetails?.atomicNumber

    symbolLabel.text = symbol
    atomNameLabel.text = atomName ?? symbol

    coordinatesView.coordinates = atom?.position

    guard let details = atomDetails else { return }

    usefullInformationsView.informations = [
      "\(details.ligand.numberOfAtoms(withSymbol: details.atom.symbol)) occur.", // number of occurences of this symbol in the ligand
      "\(details.atom.linkedAtoms.count) link(s)", // number of links with other atomes
      "Z = \(atomicNumber ?? 0)" // Z is the atomic number
    ]
  }

  
}
