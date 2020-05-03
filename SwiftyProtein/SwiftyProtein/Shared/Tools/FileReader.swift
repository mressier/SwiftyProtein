import Foundation

struct FileReader {

  /// Return ligand file content as an array of lines
  static func readLigandFile() -> [String] {
    let fileContent = String(decoding: SPAssets.ligands.data.data,
                             as: UTF8.self)
    return fileContent.split(separator: "\n").map() { String($0) }
  }

}
