import Foundation

fileprivate typealias APos = AtomPosition

struct FakeLigands {

  static let atp = [
    Atom(index: 1, name: "PG", position: APos(x: 1.200, y: -0.226, z: -6.850), linkedAtoms: [2,  3,  4,  8], color: .green),
    Atom(index: 2, name: "O1G", position: APos(x: 1.740,  y: 1.140, z: -6.672), linkedAtoms: [1], color: .green),
    Atom(index: 3, name: "O2G", position: APos(x: 2.123, y: -1.036, z: -7.891), linkedAtoms: [1, 32], color: .green),
    Atom(index: 4, name: "O3G", position: APos(x: -0.302, y: -0.139, z: -7.421), linkedAtoms: [4,  1, 33], color: .green),
    Atom(index: 5, name: "PB", position: APos(x: 0.255, y: -0.130, z: -4.446), linkedAtoms: [5,  6,  7,  8, 12], color: .green),
    Atom(index: 6, name: "O1B", position: APos(x: 0.810,  y: 1.234, z: -4.304), linkedAtoms: [6,  5], color: .green),
    Atom(index: 7, name: "O2B", position: APos(x: -1.231, y: -0.044, z: -5.057), linkedAtoms: [7,  5, 34], color: .green),
    Atom(index: 8, name: "O3B", position: APos(x: 1.192, y: -0.990, z: -5.433), linkedAtoms: [8,  1,  5], color: .green),
    Atom(index: 9, name: "PA", position: APos(x: -0.745,  y: 0.068, z: -2.071), linkedAtoms: [9, 10, 11, 12, 13], color: .green),
    Atom(index: 10, name: "O1A", position: APos(x: -2.097,  y: 0.143, z: -2.669), linkedAtoms: [10,  9], color: .green),
    Atom(index: 11, name: "O2A", position: APos(x: -0.125,  y: 1.549, z: -1.957), linkedAtoms: [11,  9, 35], color: .green),
    Atom(index: 12, name: "O3A", position: APos(x: 0.203, y: -0.840, z: -3.002), linkedAtoms: [12,  5,  9], color: .green),
    Atom(index: 13, name: "O5'", position: APos(x: -0.844, y: -0.587, z: -0.604), linkedAtoms: [13,  9, 14], color: .green),
    Atom(index: 14, name: "C5'", position: APos(x: -1.694,  y: 0.260, z:  0.170), linkedAtoms: [14, 13, 15, 36, 37], color: .green),
    Atom(index: 15, name: "C4'", position: APos(x: -1.831, y: -0.309, z:  1.584), linkedAtoms: [15, 14, 16, 17, 38], color: .green),
    Atom(index: 16, name: "O4'", position: APos(x: -0.542, y: -0.355, z:  2.234), linkedAtoms: [16, 15, 21], color: .green),
    Atom(index: 17, name: "C3'", position: APos(x: -2.683,  y: 0.630, z:  2.465), linkedAtoms: [17, 15, 18, 19, 39], color: .green),
    Atom(index: 18, name: "O3'", position: APos(x: -4.033,  y: 0.165, z:  2.534), linkedAtoms: [18, 17, 40], color: .green),
    Atom(index: 19, name: "C2'", position: APos(x: -2.011,  y: 0.555, z:  3.856), linkedAtoms: [19, 17, 20, 21, 41], color: .green),
    Atom(index: 20, name: "O2'", position: APos(x: -2.926,  y: 0.043, z:  4.827), linkedAtoms: [20, 19, 42], color: .green),
    Atom(index: 21, name: "C1'", position: APos(x: -0.830, y: -0.418, z:  3.647), linkedAtoms: [21, 16, 19, 22, 43], color: .green),
    Atom(index: 22, name: "N9", position: APos(x: 0.332,  y: 0.015, z:  4.425), linkedAtoms: [22, 21, 23, 31], color: .green),
    Atom(index: 23, name: "C8", position: APos(x: 1.302,  y: 0.879, z:  4.012), linkedAtoms: [23, 22, 24, 44], color: .green),
    Atom(index: 24, name: "N7", position: APos(x: 2.184,  y: 1.042, z:  4.955), linkedAtoms: [24, 23, 25], color: .green),
    Atom(index: 25, name: "C5", position: APos(x: 1.833,  y: 0.300, z:  6.033), linkedAtoms: [25, 24, 26, 31], color: .green),
    Atom(index: 26, name: "C6", position: APos(x: 2.391,  y: 0.077, z:  7.303), linkedAtoms: [26, 25, 27, 28], color: .green),
    Atom(index: 27, name: "N6", position: APos(x: 3.564,  y: 0.706, z:  7.681), linkedAtoms: [27, 26, 45, 46], color: .green),
    Atom(index: 28, name: "N1", position: APos(x: 1.763, y: -0.747, z:  8.135), linkedAtoms: [28, 26, 29], color: .green),
    Atom(index: 29, name: "C2", position: APos(x: 0.644, y: -1.352, z:  7.783), linkedAtoms: [29, 28, 30, 47], color: .green),
    Atom(index: 30, name: "N3", position: APos(x: 0.088, y: -1.178, z:  6.602), linkedAtoms: [30, 29, 31], color: .green),
    Atom(index: 31, name: "C4", position: APos(x: 0.644, y: -0.371, z:  5.704), linkedAtoms: [31, 22, 25, 30], color: .green),
    Atom(index: 32, name: "HOG2", position: APos(x: 2.100, y: -0.546, z: -8.725), linkedAtoms: [32,  3], color: .green),
    Atom(index: 33, name: "HOG3", position: APos(x: -0.616, y: -1.048, z: -7.522), linkedAtoms: [33,  4], color: .green),
    Atom(index: 34, name: "HOB2", position: APos(x: -1.554, y: -0.952, z: -5.132), linkedAtoms: [34,  7], color: .green),
    Atom(index: 35, name: "HOA2", position: APos(x: 0.752,  y: 1.455, z: -1.563), linkedAtoms: [35, 11], color: .green),
    Atom(index: 36, name: "H5'1", position: APos(x: -2.678,  y: 0.312, z: -0.296), linkedAtoms: [36, 14], color: .green),
    Atom(index: 37, name: "H5'2", position: APos(x: -1.263,  y: 1.259, z:  0.221), linkedAtoms: [37, 14], color: .green),
    Atom(index: 38, name: "H4'", position: APos(x: -2.275, y: -1.304, z:  1.550), linkedAtoms: [38, 15], color: .green),
    Atom(index: 39, name: "H3'", position: APos(x: -2.651,  y: 1.649, z:  2.078), linkedAtoms: [39, 17], color: .green),
    Atom(index: 40, name: "HO3'", position: APos(x: -4.515,  y: 0.788, z:  3.094), linkedAtoms: [40, 18], color: .green),
    Atom(index: 41, name: "H2'", position: APos(x: -1.646,  y: 1.537, z:  4.157), linkedAtoms: [41, 19], color: .green),
    Atom(index: 42, name: "HO2'", position: APos(x: -3.667,  y: 0.662, z:  4.867), linkedAtoms: [42, 20], color: .green),
    Atom(index: 43, name: "H1'", position: APos(x: -1.119, y: -1.430, z:  3.931), linkedAtoms: [43, 21], color: .green),
    Atom(index: 44, name: "H8", position: APos(x: 1.334,  y: 1.357, z:  3.044), linkedAtoms: [44, 23], color: .green),
    Atom(index: 45, name: "HN61", position: APos(x: 3.938,  y: 0.548, z:  8.562), linkedAtoms: [45, 27], color: .green),
    Atom(index: 46, name: "HN62", position: APos(x: 4.015,  y: 1.303, z:  7.064), linkedAtoms: [46, 27], color: .green),
    Atom(index: 47, name: "H2", position: APos(x: 0.166, y: -2.014, z:  8.490), linkedAtoms: [4,  1, 33], color: .green),
  ]

  static let sample = [
    Atom(index: 0, position: APos(x: 1.200, y: -0.226, z: -6.850), linkedAtoms: [1, 2, 4], color: .cyan),
    Atom(index: 1, position: APos(x: 1.740, y: 1.140, z: -6.672), linkedAtoms: [0, 4, 5], color: .blue),
    Atom(index: 2, position: APos(x: -0.302, y: -0.139, z: -7.421), linkedAtoms: [0, 3], color: .red),
    Atom(index: 3, position: APos(x:  0.255, y: -0.130, z: -4.446), linkedAtoms: [2, 4], color: .green),
    Atom(index: 4, position: APos(x:  0.810, y: 1.234, z: -4.304), linkedAtoms: [0, 1, 3, 5, 6], color: .green),
    Atom(index: 5, position: APos(x: -1.231, y: -0.044, z: -5.057), linkedAtoms: [1, 4, 6], color: .cyan),
    Atom(index: 6, position: APos(x:  1.192, y: -0.990, z: -5.433), linkedAtoms: [4, 5], color: .orange)
  ]

  static let square = [
    Atom(index: 0, position: APos(x: 0, y: 0, z: 0), linkedAtoms: [1, 3], color: .cyan),
    Atom(index: 1, position: APos(x: 0, y: 3, z: 0), linkedAtoms: [0, 2], color: .blue),
    Atom(index: 2, position: APos(x: 3, y: 3, z: 0), linkedAtoms: [1, 3], color: .green),
    Atom(index: 3, position: APos(x: 3, y: 0, z: 0), linkedAtoms: [0, 2], color: .yellow),
  ]


  static let planSquare = [
    Atom(index: 0, position: APos(x: 0, y: 0, z: 0), linkedAtoms: [1, 3], color: .cyan),
    Atom(index: 1, position: APos(x: 0, y: 0, z: 3), linkedAtoms: [0, 2], color: .blue),
    Atom(index: 2, position: APos(x: 3, y: 0, z: 3), linkedAtoms: [1, 3], color: .green),
    Atom(index: 3, position: APos(x: 3, y: 0, z: 0), linkedAtoms: [0, 2], color: .yellow),
  ]

  static let cube = [
    Atom(index: 0, position: APos(x: 0, y: 0, z: 0), linkedAtoms: [1, 3, 4], color: .cyan),
    Atom(index: 1, position: APos(x: 0, y: 3, z: 0), linkedAtoms: [0, 2, 5], color: .blue),
    Atom(index: 2, position: APos(x: 3, y: 3, z: 0), linkedAtoms: [1, 3, 6], color: .green),
    Atom(index: 3, position: APos(x: 3, y: 0, z: 0), linkedAtoms: [0, 2, 7], color: .yellow),

    Atom(index: 4, position: APos(x: 0, y: 0, z: 3), linkedAtoms: [0, 5, 7], color: .cyan),
    Atom(index: 5, position: APos(x: 0, y: 3, z: 3), linkedAtoms: [1, 4, 6], color: .blue),
    Atom(index: 6, position: APos(x: 3, y: 3, z: 3), linkedAtoms: [2, 5, 7], color: .green),
    Atom(index: 7, position: APos(x: 3, y: 0, z: 3), linkedAtoms: [3, 4, 6], color: .yellow),
  ]

  static let crossCube = [
    Atom(index: 0, position: APos(x: 0, y: 0, z: 0), linkedAtoms: [1, 2, 3, 4, 5, 6, 7], color: .cyan),
    Atom(index: 1, position: APos(x: 0, y: 5, z: 0), linkedAtoms: [0, 2, 3, 4, 5, 6, 7], color: .blue),
    Atom(index: 2, position: APos(x: 5, y: 5, z: 0), linkedAtoms: [0, 1, 3, 4, 5, 6, 7], color: .green),
    Atom(index: 3, position: APos(x: 5, y: 0, z: 0), linkedAtoms: [0, 1, 2, 4, 5, 6, 7], color: .yellow),

    Atom(index: 4, position: APos(x: 0, y: 0, z: 5), linkedAtoms: [0, 1, 2, 3, 5, 6, 7], color: .cyan),
    Atom(index: 5, position: APos(x: 0, y: 5, z: 5), linkedAtoms: [0, 1, 2, 3, 4, 6, 7], color: .blue),
    Atom(index: 6, position: APos(x: 5, y: 5, z: 5), linkedAtoms: [0, 1, 2, 3, 4, 5, 7], color: .green),
    Atom(index: 7, position: APos(x: 5, y: 0, z: 5), linkedAtoms: [0, 1, 2, 3, 4, 5, 6], color: .yellow),
  ]
}
