import Foundation

struct AtomsList {

  static var hydrogen =
    AtomInfo(name: "hydrogen", symbol: "H", atomicNumber: 1, cpkColor: .white)

  static let atoms = [
    AtomsList.hydrogen,
    AtomInfo(name: "carbon", symbol: "C", atomicNumber: 6, cpkColor: .veryDarkGray),
    AtomInfo(name: "nitrogen", symbol: "N", atomicNumber: 7,  cpkColor: .blue),
    AtomInfo(name: "oxygen", symbol: "O", atomicNumber: 8, cpkColor: .red),
    AtomInfo(name: "fluorine", symbol: "F", atomicNumber: 9, cpkColor: .green),
    AtomInfo(name: "chlorine", symbol: "Cl", atomicNumber: 17, cpkColor: .green),
    AtomInfo(name: "bromine", symbol: "Br", atomicNumber: 35, cpkColor: .darkRed),
    AtomInfo(name: "iodine", symbol: "I", atomicNumber: 53, cpkColor: .darkViolet),
    AtomInfo(name: "phosphorus", symbol: "P", atomicNumber: 15, cpkColor: .orange),
    AtomInfo(name: "sulfur", symbol: "S", atomicNumber: 16, cpkColor: .yellow),
    AtomInfo(name: "titanium", symbol: "Ti", atomicNumber: 22, cpkColor: .gray),
    AtomInfo(name: "iron", symbol: "Fe", atomicNumber: 26, cpkColor: .darkOrange),
    AtomInfo(name: "helium", symbol: "He", atomicNumber: 2, cpkColor: .cyan),
    AtomInfo(name: "neon", symbol: "Ne", atomicNumber: 10, cpkColor: .cyan),
    AtomInfo(name: "argon", symbol: "Ar", atomicNumber: 18, cpkColor: .cyan),
    AtomInfo(name: "xenon", symbol: "Xe", atomicNumber: 54, cpkColor: .cyan),
    AtomInfo(name: "krypton", symbol: "Kr", atomicNumber: 36, cpkColor: .cyan),
    AtomInfo(name: "boron", symbol: "B", atomicNumber: 5, cpkColor: .salmon),
    AtomInfo(name: "lithium", symbol: "Li", atomicNumber: 3, cpkColor: .purple),
    AtomInfo(name: "sodium", symbol: "Na", atomicNumber: 11, cpkColor: .purple),
    AtomInfo(name: "potassium", symbol: "K", atomicNumber: 19, cpkColor: .purple),
    AtomInfo(name: "rubidium", symbol: "Rb", atomicNumber: 37, cpkColor: .purple),
    AtomInfo(name: "caesium", symbol: "Cs", atomicNumber: 55, cpkColor: .purple),
    AtomInfo(name: "francium", symbol: "Fr", atomicNumber: 87, cpkColor: .purple),
    AtomInfo(name: "beryllium", symbol: "Be", atomicNumber: 4, cpkColor: .darkGreen),
    AtomInfo(name: "magnesium", symbol: "Mg", atomicNumber: 12, cpkColor: .darkGreen),
    AtomInfo(name: "calcium", symbol: "Ca", atomicNumber: 20, cpkColor: .darkGreen),
    AtomInfo(name: "strontium", symbol: "Sr", atomicNumber: 38, cpkColor: .darkGreen),
    AtomInfo(name: "barium", symbol: "Ba", atomicNumber: 56, cpkColor: .darkGreen),
    AtomInfo(name: "radium", symbol: "Ra", atomicNumber: 88, cpkColor: .darkGreen)
  ]

  static var atomsBySymbol: [String: AtomInfo] = {
    var bySymbol = [String: AtomInfo]()
    for atom in AtomsList.atoms {
      bySymbol[atom.symbol] = atom
    }
    return bySymbol
  }()
}
