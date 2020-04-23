import Foundation

struct AtomsList {

  static var hydrogen =
    AtomInfo(name: "hydrogen", symbol: "H",  cpkColor: .white)

  static let atoms = [
    AtomsList.hydrogen,
    AtomInfo(name: "carbon", symbol: "C",  cpkColor: .black),
    AtomInfo(name: "nitrogen", symbol: "N",  cpkColor: .blue),
    AtomInfo(name: "oxygen", symbol: "O",  cpkColor: .red),
    AtomInfo(name: "fluorine", symbol: "F", cpkColor: .green),
    AtomInfo(name: "chlorine", symbol: "Cl", cpkColor: .green),
    AtomInfo(name: "bromine", symbol: "Br", cpkColor: .darkRed),
    AtomInfo(name: "iodine", symbol: "I", cpkColor: .darkViolet),
    AtomInfo(name: "phosphorus", symbol: "P", cpkColor: .orange),
    AtomInfo(name: "sulfur", symbol: "S", cpkColor: .yellow),
    AtomInfo(name: "titanium", symbol: "Ti", cpkColor: .gray),
    AtomInfo(name: "iron", symbol: "Fe", cpkColor: .darkOrange),
    AtomInfo(name: "helium", symbol: "He", cpkColor: .cyan),
    AtomInfo(name: "neon", symbol: "Ne", cpkColor: .cyan),
    AtomInfo(name: "argon", symbol: "Ar", cpkColor: .cyan),
    AtomInfo(name: "xenon", symbol: "Xe", cpkColor: .cyan),
    AtomInfo(name: "krypton", symbol: "Kr", cpkColor: .cyan),
    AtomInfo(name: "boron", symbol: "B", cpkColor: .salmon),
    AtomInfo(name: "lithium", symbol: "Li", cpkColor: .purple),
    AtomInfo(name: "sodium", symbol: "Na", cpkColor: .purple),
    AtomInfo(name: "potassium", symbol: "K", cpkColor: .purple),
    AtomInfo(name: "rubidium", symbol: "Rb", cpkColor: .purple),
    AtomInfo(name: "caesium", symbol: "Cs", cpkColor: .purple),
    AtomInfo(name: "francium", symbol: "Fr", cpkColor: .purple),
    AtomInfo(name: "beryllium", symbol: "Be", cpkColor: .darkGreen),
    AtomInfo(name: "magnesium", symbol: "Mg", cpkColor: .darkGreen),
    AtomInfo(name: "calcium", symbol: "Ca", cpkColor: .darkGreen),
    AtomInfo(name: "strontium", symbol: "Sr", cpkColor: .darkGreen),
    AtomInfo(name: "barium", symbol: "Ba", cpkColor: .darkGreen),
    AtomInfo(name: "radium", symbol: "Ra", cpkColor: .darkGreen),
  ]

  static var atomsBySymbol: [String: AtomInfo] = {
    var bySymbol = [String: AtomInfo]()
    for atom in AtomsList.atoms {
      bySymbol[atom.symbol] = atom
    }
    return bySymbol
  }()
}
