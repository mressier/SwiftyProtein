import Foundation

struct PDBAtom: Equatable {
  var index: Int
  var atomName: String
  var alternateLocationIndicator: String
  var residueName: String
  var chainIdentifier: String
  var residueSequenceNumber: Int
  var residueInsertionCode: String
  var x: Float
  var y: Float
  var z: Float
  var occupancy: Float
  var temperatureFactor: Float
  var symbol: String
  var charge: String
  var linkedAtomIndex: [Int]

  //----------------------------------------------------------------------------
  // MARK: - Conversion
  //----------------------------------------------------------------------------

  var lightAtom: PDBAtomLight {
    return PDBAtomLight(index: index,
                        symbol: symbol,
                        position: PDBAtomPosition(x: x, y: y, z: z),
                        linkedAtoms: linkedAtomIndex)
  }

  //----------------------------------------------------------------------------
  // MARK: - Equatable
  //----------------------------------------------------------------------------

  static func ==(_ lhs: PDBAtom, _ rhs: PDBAtom) -> Bool {
    return lhs.index == rhs.index
      && lhs.atomName == rhs.atomName
      && lhs.alternateLocationIndicator == rhs.alternateLocationIndicator
      && lhs.residueName == rhs.residueName
      && lhs.chainIdentifier == rhs.chainIdentifier
      && lhs.residueSequenceNumber == rhs.residueSequenceNumber
      && lhs.residueInsertionCode == rhs.residueInsertionCode
      && lhs.x == rhs.x
      && lhs.y == rhs.y
      && lhs.z == rhs.z
      && lhs.occupancy == rhs.occupancy
      && lhs.temperatureFactor == rhs.temperatureFactor
      && lhs.symbol == rhs.symbol
      && lhs.charge == rhs.charge
      && lhs.linkedAtomIndex == rhs.linkedAtomIndex
  }
}
