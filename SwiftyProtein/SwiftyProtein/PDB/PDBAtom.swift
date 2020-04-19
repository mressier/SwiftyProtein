import Foundation

struct PDBAtom {
  var index: Int
  var atomName: String
  var alternateLocationIndicator: String
  var residueName: String
  var chainIdentifier: String
  var residueSequenceNumber: String
  var residueInsertionCode: Int
  var x: Float
  var y: Float
  var z: Float
  var occupancy: Float
  var temperatureFactor: Float
  var symbol: String
  var charge: String
  var linkedAtomIndex: [Int]

  var lightAtom: PDBAtom {
    return PDBAtomLight(index: index,
                        symbol: symbol,
                        position: PDBAtomPosition(x: x, y: y, z: z),
                        linkedAtoms: linkedAtomIndex)
  }
}
