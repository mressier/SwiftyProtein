import Foundation
import Alamofire

struct PDBLigandProvider {

  enum LigandProviderError: Error {
    case unknown
  }

  static func getLigand(
    _ name: String,
    completion: @escaping ((Result<PDBLigand, Error>?) -> Void)
  ) {
    let url = buildURL(forLigand: name)
    AF.request(url).response { result in

      if let error = result.error {
        print(error)
        completion(.failure(error))
        return
      }

      guard let data = result.data else {
        completion(.failure(LigandProviderError.unknown))
        print("cannot get data")
        return
      }

      let string = String(decoding: data, as: UTF8.self)
      let lines = string.split(separator: "\n").map() { String($0) }

      do {
        let ligand = try PDBLigandConverter.ligand(from: lines)
        completion(.success(ligand))
      } catch {
        completion(.failure(error))
      }
    }
  }

  static func buildURL(forLigand ligand: String) -> String {
    let baseURL = "http://ligand-expo.rcsb.org/reports/"
    let baseSuffix = "_ideal.pdb"
    let urlContent = String(format: "%1$@/%2$@/%2$@",
                            String(ligand.prefix(1)),
                            ligand)
    let urlComplete = "\(baseURL)\(urlContent)\(baseSuffix)"

    return urlComplete
  }
  
}
