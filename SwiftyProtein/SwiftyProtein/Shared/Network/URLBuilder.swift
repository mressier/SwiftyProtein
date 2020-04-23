import Foundation

struct URLBuilder {

  static func build(forLigand ligand: String,
                    urlPrefix: String,
                    urlSuffix: String) -> String {
    let urlContent = buildLigandPath(ligand)
    let urlComplete = "\(urlPrefix)\(urlContent)\(urlSuffix)"
    return urlComplete
  }

  private static func buildLigandPath(_ ligand: String) -> String {
    let ligandFormat = "%1$@/%2$@/%2$@"
    let urlContent = String(format: ligandFormat,
                            String(ligand.prefix(1)),
                            ligand)
    return urlContent
  }
}
