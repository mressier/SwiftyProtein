import UIKit

/*******************************************************************************
 * LigandCollection
 *
 * Structures related to the ligand collection
 *
 ******************************************************************************/
struct LigandCollection {

  /*******************************************************************************
   * LigandCollection.Header
   *
   * Represent a section header informations in the ligand collection
   *
   ******************************************************************************/
  struct Header {
    let title: String?
    let image: UIImage?
  }

  /*******************************************************************************
   * LigandCollection.Ligand
   *
   * Represent a ligand informations in the ligand collection
   *
   ******************************************************************************/
  struct Ligand: Equatable  {
    let name: String?

    static func == (_ rhs: LigandCollection.Ligand,
                    _ lhs: LigandCollection.Ligand) -> Bool {
      return rhs.name == lhs.name
    }

  }
}
