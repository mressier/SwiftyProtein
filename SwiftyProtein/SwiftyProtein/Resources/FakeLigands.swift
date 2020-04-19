import UIKit

fileprivate typealias APos = PDBAtomPosition

let mult = CGFloat(1.5)

struct FakeLigands {

  static let atp = [
    PDBAtom(index: 1, symbol: "P", position: APos(x: 1.200, y: -0.226, z: -6.850, mult: mult), linkedAtoms: [2,  3,  4,  8]),
    PDBAtom(index: 2, symbol: "O", position: APos(x: 1.740, y: 1.140, z: -6.672, mult: mult), linkedAtoms: [1]),
    PDBAtom(index: 3, symbol: "O", position: APos(x: 2.123, y: -1.036, z: -7.891, mult: mult), linkedAtoms: [1, 32]),
    PDBAtom(index: 4, symbol: "O", position: APos(x: -0.302, y: -0.139, z: -7.421, mult: mult), linkedAtoms: [4,  1, 33]),
    PDBAtom(index: 5, symbol: "P", position: APos(x: 0.255, y: -0.130, z: -4.446, mult: mult), linkedAtoms: [5,  6,  7,  8, 12]),
    PDBAtom(index: 6, symbol: "O", position: APos(x: 0.810, y: 1.234, z: -4.304, mult: mult), linkedAtoms: [6,  5]),
    PDBAtom(index: 7, symbol: "O", position: APos(x: -1.231, y: -0.044, z: -5.057, mult: mult), linkedAtoms: [7,  5, 34]),
    PDBAtom(index: 8, symbol: "O", position: APos(x: 1.192, y: -0.990, z: -5.433, mult: mult), linkedAtoms: [8,  1,  5]),
    PDBAtom(index: 9, symbol: "P", position: APos(x: -0.745, y: 0.068, z: -2.071, mult: mult), linkedAtoms: [9, 10, 11, 12, 13]),
    PDBAtom(index: 10, symbol: "O", position: APos(x: -2.097, y: 0.143, z: -2.669, mult: mult), linkedAtoms: [10,  9]),
    PDBAtom(index: 11, symbol: "O", position: APos(x: -0.125, y: 1.549, z: -1.957, mult: mult), linkedAtoms: [11,  9, 35]),
    PDBAtom(index: 12, symbol: "O", position: APos(x: 0.203, y: -0.840, z: -3.002, mult: mult), linkedAtoms: [12,  5,  9]),
    PDBAtom(index: 13, symbol: "O", position: APos(x: -0.844, y: -0.587, z: -0.604, mult: mult), linkedAtoms: [13,  9, 14]),
    PDBAtom(index: 14, symbol: "C", position: APos(x: -1.694,  y: 0.260, z:  0.170, mult: mult), linkedAtoms: [14, 13, 15, 36, 37]),
    PDBAtom(index: 15, symbol: "C", position: APos(x: -1.831, y: -0.309, z:  1.584, mult: mult), linkedAtoms: [15, 14, 16, 17, 38]),
    PDBAtom(index: 16, symbol: "O", position: APos(x: -0.542, y: -0.355, z:  2.234, mult: mult), linkedAtoms: [16, 15, 21]),
    PDBAtom(index: 17, symbol: "C", position: APos(x: -2.683, y: 0.630, z:  2.465, mult: mult), linkedAtoms: [17, 15, 18, 19, 39]),
    PDBAtom(index: 18, symbol: "O", position: APos(x: -4.033, y: 0.165, z:  2.534, mult: mult), linkedAtoms: [18, 17, 40]),
    PDBAtom(index: 19, symbol: "C", position: APos(x: -2.011, y: 0.555, z:  3.856, mult: mult), linkedAtoms: [19, 17, 20, 21, 41]),
    PDBAtom(index: 20, symbol: "O", position: APos(x: -2.926, y: 0.043, z:  4.827, mult: mult), linkedAtoms: [20, 19, 42]),
    PDBAtom(index: 21, symbol: "C'", position: APos(x: -0.830, y: -0.418, z:  3.647, mult: mult), linkedAtoms: [21, 16, 19, 22, 43]),
    PDBAtom(index: 22, symbol: "N", position: APos(x: 0.332, y: 0.015, z: 4.425, mult: mult), linkedAtoms: [22, 21, 23, 31]),
    PDBAtom(index: 23, symbol: "C", position: APos(x: 1.302, y: 0.879, z: 4.012, mult: mult), linkedAtoms: [23, 22, 24, 44]),
    PDBAtom(index: 24, symbol: "N", position: APos(x: 2.184, y: 1.042, z: 4.955, mult: mult), linkedAtoms: [24, 23, 25]),
    PDBAtom(index: 25, symbol: "C", position: APos(x: 1.833, y: 0.300, z: 6.033, mult: mult), linkedAtoms: [25, 24, 26, 31]),
    PDBAtom(index: 26, symbol: "C", position: APos(x: 2.391, y: 0.077, z: 7.303, mult: mult), linkedAtoms: [26, 25, 27, 28]),
    PDBAtom(index: 27, symbol: "N", position: APos(x: 3.564, y: 0.706, z: 7.681, mult: mult), linkedAtoms: [27, 26, 45, 46]),
    PDBAtom(index: 28, symbol: "N", position: APos(x: 1.763, y: -0.747, z: 8.135, mult: mult), linkedAtoms: [28, 26, 29]),
    PDBAtom(index: 29, symbol: "C", position: APos(x: 0.644, y: -1.352, z: 7.783, mult: mult), linkedAtoms: [29, 28, 30, 47]),
    PDBAtom(index: 30, symbol: "N", position: APos(x: 0.088, y: -1.178, z: 6.602, mult: mult), linkedAtoms: [30, 29, 31]),
    PDBAtom(index: 31, symbol: "C", position: APos(x: 0.644, y: -0.371, z: 5.704, mult: mult), linkedAtoms: [31, 22, 25, 30]),
    PDBAtom(index: 32, symbol: "H", position: APos(x: 2.100, y: -0.546, z: -8.725, mult: mult), linkedAtoms: [32,  3]),
    PDBAtom(index: 33, symbol: "H", position: APos(x: -0.616, y: -1.048, z: -7.522, mult: mult), linkedAtoms: [33,  4]),
    PDBAtom(index: 34, symbol: "H", position: APos(x: -1.554, y: -0.952, z: -5.132, mult: mult), linkedAtoms: [34,  7]),
    PDBAtom(index: 35, symbol: "H", position: APos(x: 0.752,  y: 1.455, z: -1.563, mult: mult), linkedAtoms: [35, 11]),
    PDBAtom(index: 36, symbol: "H", position: APos(x: -2.678,  y: 0.312, z: -0.296, mult: mult), linkedAtoms: [36, 14]),
    PDBAtom(index: 37, symbol: "H", position: APos(x: -1.263,  y: 1.259, z:  0.221, mult: mult), linkedAtoms: [37, 14]),
    PDBAtom(index: 38, symbol: "H", position: APos(x: -2.275, y: -1.304, z:  1.550, mult: mult), linkedAtoms: [38, 15]),
    PDBAtom(index: 39, symbol: "H", position: APos(x: -2.651,  y: 1.649, z:  2.078, mult: mult), linkedAtoms: [39, 17]),
    PDBAtom(index: 40, symbol: "H", position: APos(x: -4.515,  y: 0.788, z:  3.094, mult: mult), linkedAtoms: [40, 18]),
    PDBAtom(index: 41, symbol: "H", position: APos(x: -1.646,  y: 1.537, z:  4.157, mult: mult), linkedAtoms: [41, 19]),
    PDBAtom(index: 42, symbol: "H", position: APos(x: -3.667,  y: 0.662, z:  4.867, mult: mult), linkedAtoms: [42, 20]),
    PDBAtom(index: 43, symbol: "H", position: APos(x: -1.119, y: -1.430, z:  3.931, mult: mult), linkedAtoms: [43, 21]),
    PDBAtom(index: 44, symbol: "H", position: APos(x: 1.334,  y: 1.357, z:  3.044, mult: mult), linkedAtoms: [44, 23]),
    PDBAtom(index: 45, symbol: "H", position: APos(x: 3.938,  y: 0.548, z:  8.562, mult: mult), linkedAtoms: [45, 27]),
    PDBAtom(index: 46, symbol: "H", position: APos(x: 4.015,  y: 1.303, z:  7.064, mult: mult), linkedAtoms: [46, 27]),
    PDBAtom(index: 47, symbol: "H", position: APos(x: 0.166, y: -2.014, z:  8.490, mult: mult), linkedAtoms: [4,  1, 33]),
  ]

  static let sample = [
    PDBAtom(index: 0, position: APos(x: 1.200, y: -0.226, z: -6.850), linkedAtoms: [1, 2, 4]),
    PDBAtom(index: 1, position: APos(x: 1.740, y: 1.140, z: -6.672), linkedAtoms: [0, 4, 5]),
    PDBAtom(index: 2, position: APos(x: -0.302, y: -0.139, z: -7.421), linkedAtoms: [0, 3]),
    PDBAtom(index: 3, position: APos(x:  0.255, y: -0.130, z: -4.446), linkedAtoms: [2, 4]),
    PDBAtom(index: 4, position: APos(x:  0.810, y: 1.234, z: -4.304), linkedAtoms: [0, 1, 3, 5, 6]),
    PDBAtom(index: 5, position: APos(x: -1.231, y: -0.044, z: -5.057), linkedAtoms: [1, 4, 6]),
    PDBAtom(index: 6, position: APos(x:  1.192, y: -0.990, z: -5.433), linkedAtoms: [4, 5])
  ]

  static let square = [
    PDBAtom(index: 0, position: APos(x: 0, y: 0, z: 0), linkedAtoms: [1, 3]),
    PDBAtom(index: 1, position: APos(x: 0, y: 3, z: 0), linkedAtoms: [0, 2]),
    PDBAtom(index: 2, position: APos(x: 3, y: 3, z: 0), linkedAtoms: [1, 3]),
    PDBAtom(index: 3, position: APos(x: 3, y: 0, z: 0), linkedAtoms: [0, 2]),
  ]


  static let planSquare = [
    PDBAtom(index: 0, position: APos(x: 0, y: 0, z: 0), linkedAtoms: [1, 3]),
    PDBAtom(index: 1, position: APos(x: 0, y: 0, z: 3), linkedAtoms: [0, 2]),
    PDBAtom(index: 2, position: APos(x: 3, y: 0, z: 3), linkedAtoms: [1, 3]),
    PDBAtom(index: 3, position: APos(x: 3, y: 0, z: 0), linkedAtoms: [0, 2]),
  ]

  static let cube = [
    PDBAtom(index: 0, position: APos(x: 0, y: 0, z: 0), linkedAtoms: [1, 3, 4]),
    PDBAtom(index: 1, position: APos(x: 0, y: 3, z: 0), linkedAtoms: [0, 2, 5]),
    PDBAtom(index: 2, position: APos(x: 3, y: 3, z: 0), linkedAtoms: [1, 3, 6]),
    PDBAtom(index: 3, position: APos(x: 3, y: 0, z: 0), linkedAtoms: [0, 2, 7]),

    PDBAtom(index: 4, position: APos(x: 0, y: 0, z: 3), linkedAtoms: [0, 5, 7]),
    PDBAtom(index: 5, position: APos(x: 0, y: 3, z: 3), linkedAtoms: [1, 4, 6]),
    PDBAtom(index: 6, position: APos(x: 3, y: 3, z: 3), linkedAtoms: [2, 5, 7]),
    PDBAtom(index: 7, position: APos(x: 3, y: 0, z: 3), linkedAtoms: [3, 4, 6]),
  ]

  static let crossCube = [
    PDBAtom(index: 0, position: APos(x: 0, y: 0, z: 0), linkedAtoms: [1, 2, 3, 4, 5, 6, 7]),
    PDBAtom(index: 1, position: APos(x: 0, y: 5, z: 0), linkedAtoms: [0, 2, 3, 4, 5, 6, 7]),
    PDBAtom(index: 2, position: APos(x: 5, y: 5, z: 0), linkedAtoms: [0, 1, 3, 4, 5, 6, 7]),
    PDBAtom(index: 3, position: APos(x: 5, y: 0, z: 0), linkedAtoms: [0, 1, 2, 4, 5, 6, 7]),

    PDBAtom(index: 4, position: APos(x: 0, y: 0, z: 5), linkedAtoms: [0, 1, 2, 3, 5, 6, 7]),
    PDBAtom(index: 5, position: APos(x: 0, y: 5, z: 5), linkedAtoms: [0, 1, 2, 3, 4, 6, 7]),
    PDBAtom(index: 6, position: APos(x: 5, y: 5, z: 5), linkedAtoms: [0, 1, 2, 3, 4, 5, 7]),
    PDBAtom(index: 7, position: APos(x: 5, y: 0, z: 5), linkedAtoms: [0, 1, 2, 3, 4, 5, 6]),
  ]
}
