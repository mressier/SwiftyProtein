import Foundation

extension PDBLigandConverter {

  enum ReadState: Int {
    case atomList = 0
    case connectionList
    case end

    /******************** Iterate through status ********************/
    
    var next: ReadState {
      return ReadState(rawValue: self.rawValue + 1) ?? .end
    }

    /******************** Input type for current status ********************/

    func checkInputType(_ string: String) -> Bool {
      switch self {
      case .atomList:
        let isAtom = PDBLigandConverter.isAtomInput(string: string)
        let isHetatm = PDBLigandConverter.isHetatmInput(string: string)
        return isAtom || isHetatm
      case .connectionList:
        return PDBLigandConverter.isConectInput(string: string)
      case .end: return PDBLigandConverter.isEndInput(string: string)
      }
    }
  }

}
