import Foundation
import Unicorp_DataTypesLibrary

extension PDBLigandConverter {

  private static var ATOM_INPUT = "ATOM"
  private static var HETATM_INPUT = "HETATM"

  private static var ATOM_REGEX =
    "^(.{6})(.{5}) (.{4})(.{1})(.{3}) (.{1})(.{4})(.{1})   (.{8})(.{8})(.{8})(.{6})(.{6}) {10}(.{2})"

  //----------------------------------------------------------------------------
  // MARK: - Format
  //----------------------------------------------------------------------------

  static func isAtomInput(string: String) -> Bool {
    return string.starts(with: ATOM_INPUT)
  }

  static func isHetatmInput(string: String) -> Bool {
    return string.starts(with: HETATM_INPUT)
  }

  //----------------------------------------------------------------------------
  // MARK: - PDB Atom Conversion
  //----------------------------------------------------------------------------

  static func atom(from line: String) throws -> PDBAtom {
    guard let atomParts = getAtomParts(from: line) else {
      throw ContentError.invalidAtomLineFormat(line)
    }

    guard atomParts[0] == ATOM_INPUT else {
      throw ContentError.invalidAtomValue("Not an atom input \(atomParts[0])")
    }

    guard let index = Int(atomParts[1]) else {
      throw ContentError.invalidAtomValue("Invalid index \(atomParts[1])")
    }
    guard let residueSequenceNumber = Int(atomParts[6]) else {
      throw ContentError.invalidAtomValue(
        "Invalid residueSequenceNumber \(atomParts[6])"
      )
    }
    guard let x = Float(atomParts[8]) else {
      throw ContentError.invalidAtomValue("Invalid x falue \(atomParts[8])")
    }
    guard let y = Float(atomParts[9]) else {
      throw ContentError.invalidAtomValue("Invalid y value \(atomParts[9])")
    }
    guard let z = Float(atomParts[10]) else {
      throw ContentError.invalidAtomValue("Invalid z value \(atomParts[10])")
    }
    guard let occupancy = Float(atomParts[11]) else {
      throw ContentError.invalidAtomValue("Invalid occupancy \(atomParts[11])"
      )
    }
    guard let temperatureFactor = Float(atomParts[12]) else {
      throw ContentError.invalidAtomValue(
        "Invalid temperature factor \(atomParts[12])"
      )
    }

    return PDBAtom(index: index,
                   atomName: atomParts[2],
                   alternateLocationIndicator: atomParts[3],
                   residueName: atomParts[4],
                   chainIdentifier: atomParts[5],
                   residueSequenceNumber: residueSequenceNumber,
                   residueInsertionCode: atomParts[7],
                   x: x,
                   y: y,
                   z: z,
                   occupancy: occupancy,
                   temperatureFactor: temperatureFactor,
                   symbol: atomParts[13],
                   charge: "",
                   linkedAtomIndex: [])
  }

  //----------------------------------------------------------------------------
  // MARK: - Tool
  //----------------------------------------------------------------------------

  private static func getAtomParts(from line: String) -> [String]? {
    guard var atomParts =
            try? line.substringMatches(regex: ATOM_REGEX).first else {
      return nil
    }

    atomParts.remove(at: 0) // remove global match

    guard atomParts.count == 14 else {
      print("count invalid \(atomParts.count)")
      return nil
    }

    let trimmedParts = atomParts.map() { $0.trimmed() }

    return trimmedParts
  }
}
