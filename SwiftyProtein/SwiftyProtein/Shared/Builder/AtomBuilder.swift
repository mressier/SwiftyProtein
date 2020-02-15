import UIKit

class AtomBuilder {
  static func build() -> [Atom] {
    return [
      Atom(index: 0, name: "0", position: AtomPosition(x: 1.200, y: -0.226, z: -6.850), linkedAtoms: [2, 4], color: .cyan),
      Atom(index: 1, name: "1", position: AtomPosition(x: 1.740, y: 1.140, z: -6.672), linkedAtoms: [4], color: .blue),
      Atom(index: 2, name: "2", position: AtomPosition(x: -0.302, y: -0.139, z: -7.421), linkedAtoms: [3], color: .red),
      Atom(index: 3, name: "3", position: AtomPosition(x:  0.255, y: -0.130, z: -4.446), linkedAtoms: [4], color: .green),
      Atom(index: 4, name: "4", position: AtomPosition(x:  0.810, y: 1.234, z: -4.304), linkedAtoms: [5, 6], color: .green),
      Atom(index: 5, name: "5", position: AtomPosition(x: -1.231, y: -0.044, z: -5.057), linkedAtoms: [1], color: .cyan),
      Atom(index: 6, name: "6", position: AtomPosition(x:  1.192, y: -0.990, z: -5.433), linkedAtoms: [7], color: .orange),
    ]
  }
}

