import Foundation
import SceneKit

struct AtomGraphicData {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  let index: Int
  let name: String
  let position: SCNVector3
  let color: UIColor?
  let linkedAtomIndexes: [Int]

  /******************** UI Parameters ********************/

  var isSelected = false

  /******************** Computed Properties ********************/

  /// Check if the atom is an hydrogen atom with his name
  var isHydrogen: Bool {
    return name == AtomsList.hydrogen.symbol
  }

  /// Return linked atoms with an index higher than the current atom index
  var higherLinkedAtomsIndexes: [Int] {
    return linkedAtomIndexes.filter() { $0 > index }
  }
}
