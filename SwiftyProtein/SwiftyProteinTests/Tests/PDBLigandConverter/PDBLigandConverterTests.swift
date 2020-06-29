import XCTest
@testable import SwiftyProtein

class PDBLigandConverterTests: XCTestCase {

  let AUString: String = """
  ATOM      1 AU    AU A   1       0.000   0.000   0.000  1.00 10.00          AU
  END
  """

  func testLigandConverter_Sample() {
    let splittedString = AUString.split(separator: "\n").map() { String($0) }

    // When
    let ligand = try? PDBLigandConverter.ligand(name: "AU",
                                                coordinatesModel: .ideal,
                                                from: splittedString)

    // Then
    XCTAssertEqual(
      PDBLigand(name: "AU", coordinatesModel: .ideal, atoms: [
        PDBAtom(index: 1,
                atomName: "AU",
                alternateLocationIndicator: "",
                residueName: "AU",
                chainIdentifier: "A",
                residueSequenceNumber: 1,
                residueInsertionCode: "",
                x: 0.0, y: 0.0, z: 0.0,
                occupancy: 1.0,
                temperatureFactor: 10.0,
                symbol: "AU",
                charge: "",
                linkedAtomIndex: [])
    ]), ligand)
  }
}
