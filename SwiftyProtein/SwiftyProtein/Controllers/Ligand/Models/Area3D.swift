import Foundation

/*******************************************************************************
 * Area3D
 *
 * Represent an area in space, starting a min and ending at max
 *
 ******************************************************************************/
class Area3D {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var min: PDBAtomPosition
  var max: PDBAtomPosition

  //----------------------------------------------------------------------------
  // MARK: - Initialization
  //----------------------------------------------------------------------------

  init(min: PDBAtomPosition, max: PDBAtomPosition) {
    self.min = PDBAtomPosition(copy: min)
    self.max = PDBAtomPosition(copy: max)
  }

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  func update(min compare: PDBAtomPosition) {
    min.x = Swift.min(compare.x, min.x)
    min.y = Swift.min(compare.y, min.y)
    min.z = Swift.min(compare.z, min.z)
  }

  func update(max compare: PDBAtomPosition) {
    max.x = Swift.max(compare.x, max.x)
    max.y = Swift.max(compare.y, max.y)
    max.z = Swift.max(compare.z, max.z)
  }
}

extension Area3D: CustomStringConvertible {
  var description: String {
    return "{min: \(min) -> max: \(max)}"
  }
}
