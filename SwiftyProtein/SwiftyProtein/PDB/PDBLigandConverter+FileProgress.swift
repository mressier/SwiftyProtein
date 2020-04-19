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
        return PDBLigandConverter.isAtomInput(string: string)
      case .connectionList:
        return PDBLigandConverter.isConnectionInput(string: string)
      case .end: return false
      }
    }
  }

}
