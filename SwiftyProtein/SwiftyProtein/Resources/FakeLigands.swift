import UIKit
import SceneKit

let mult = CGFloat(1.5)

struct FakeLigands {

  static let atp = [
    AtomGraphicData(index: 1, name: "P", position: SCNVector3(x: 1.200, y: -0.226, z: -6.850), color: .black, linkedAtomIndexes: [2,  3,  4,  8]),
    AtomGraphicData(index: 2, name: "O", position: SCNVector3(x: 1.740, y: 1.140, z: -6.672), color: .black, linkedAtomIndexes: [1]),
    AtomGraphicData(index: 3, name: "O", position: SCNVector3(x: 2.123, y: -1.036, z: -7.891), color: .black, linkedAtomIndexes: [1, 32]),
    AtomGraphicData(index: 4, name: "O", position: SCNVector3(x: -0.302, y: -0.139, z: -7.421), color: .black, linkedAtomIndexes: [4,  1, 33]),
    AtomGraphicData(index: 5, name: "P", position: SCNVector3(x: 0.255, y: -0.130, z: -4.446), color: .black, linkedAtomIndexes: [5,  6,  7,  8, 12]),
    AtomGraphicData(index: 6, name: "O", position: SCNVector3(x: 0.810, y: 1.234, z: -4.304), color: .black, linkedAtomIndexes: [6,  5]),
    AtomGraphicData(index: 7, name: "O", position: SCNVector3(x: -1.231, y: -0.044, z: -5.057), color: .black, linkedAtomIndexes: [7,  5, 34]),
    AtomGraphicData(index: 8, name: "O", position: SCNVector3(x: 1.192, y: -0.990, z: -5.433), color: .black, linkedAtomIndexes: [8,  1,  5]),
    AtomGraphicData(index: 9, name: "P", position: SCNVector3(x: -0.745, y: 0.068, z: -2.071), color: .black, linkedAtomIndexes: [9, 10, 11, 12, 13]),
    AtomGraphicData(index: 10, name: "O", position: SCNVector3(x: -2.097, y: 0.143, z: -2.669), color: .black, linkedAtomIndexes: [10,  9]),
    AtomGraphicData(index: 11, name: "O", position: SCNVector3(x: -0.125, y: 1.549, z: -1.957), color: .black, linkedAtomIndexes: [11,  9, 35]),
    AtomGraphicData(index: 12, name: "O", position: SCNVector3(x: 0.203, y: -0.840, z: -3.002), color: .black, linkedAtomIndexes: [12,  5,  9]),
    AtomGraphicData(index: 13, name: "O", position: SCNVector3(x: -0.844, y: -0.587, z: -0.604), color: .black, linkedAtomIndexes: [13,  9, 14]),
    AtomGraphicData(index: 14, name: "C", position: SCNVector3(x: -1.694,  y: 0.260, z:  0.170), color: .black, linkedAtomIndexes: [14, 13, 15, 36, 37]),
    AtomGraphicData(index: 15, name: "C", position: SCNVector3(x: -1.831, y: -0.309, z:  1.584), color: .black, linkedAtomIndexes: [15, 14, 16, 17, 38]),
    AtomGraphicData(index: 16, name: "O", position: SCNVector3(x: -0.542, y: -0.355, z:  2.234), color: .black, linkedAtomIndexes: [16, 15, 21]),
    AtomGraphicData(index: 17, name: "C", position: SCNVector3(x: -2.683, y: 0.630, z:  2.465), color: .black, linkedAtomIndexes: [17, 15, 18, 19, 39]),
    AtomGraphicData(index: 18, name: "O", position: SCNVector3(x: -4.033, y: 0.165, z:  2.534), color: .black, linkedAtomIndexes: [18, 17, 40]),
    AtomGraphicData(index: 19, name: "C", position: SCNVector3(x: -2.011, y: 0.555, z:  3.856), color: .black, linkedAtomIndexes: [19, 17, 20, 21, 41]),
    AtomGraphicData(index: 20, name: "O", position: SCNVector3(x: -2.926, y: 0.043, z:  4.827), color: .black, linkedAtomIndexes: [20, 19, 42]),
    AtomGraphicData(index: 21, name: "C'", position: SCNVector3(x: -0.830, y: -0.418, z:  3.647), color: .black, linkedAtomIndexes: [21, 16, 19, 22, 43]),
    AtomGraphicData(index: 22, name: "N", position: SCNVector3(x: 0.332, y: 0.015, z: 4.425), color: .black, linkedAtomIndexes: [22, 21, 23, 31]),
    AtomGraphicData(index: 23, name: "C", position: SCNVector3(x: 1.302, y: 0.879, z: 4.012), color: .black, linkedAtomIndexes: [23, 22, 24, 44]),
    AtomGraphicData(index: 24, name: "N", position: SCNVector3(x: 2.184, y: 1.042, z: 4.955), color: .black, linkedAtomIndexes: [24, 23, 25]),
    AtomGraphicData(index: 25, name: "C", position: SCNVector3(x: 1.833, y: 0.300, z: 6.033), color: .black, linkedAtomIndexes: [25, 24, 26, 31]),
    AtomGraphicData(index: 26, name: "C", position: SCNVector3(x: 2.391, y: 0.077, z: 7.303), color: .black, linkedAtomIndexes: [26, 25, 27, 28]),
    AtomGraphicData(index: 27, name: "N", position: SCNVector3(x: 3.564, y: 0.706, z: 7.681), color: .black, linkedAtomIndexes: [27, 26, 45, 46]),
    AtomGraphicData(index: 28, name: "N", position: SCNVector3(x: 1.763, y: -0.747, z: 8.135), color: .black, linkedAtomIndexes: [28, 26, 29]),
    AtomGraphicData(index: 29, name: "C", position: SCNVector3(x: 0.644, y: -1.352, z: 7.783), color: .black, linkedAtomIndexes: [29, 28, 30, 47]),
    AtomGraphicData(index: 30, name: "N", position: SCNVector3(x: 0.088, y: -1.178, z: 6.602), color: .black, linkedAtomIndexes: [30, 29, 31]),
    AtomGraphicData(index: 31, name: "C", position: SCNVector3(x: 0.644, y: -0.371, z: 5.704), color: .black, linkedAtomIndexes: [31, 22, 25, 30]),
    AtomGraphicData(index: 32, name: "H", position: SCNVector3(x: 2.100, y: -0.546, z: -8.725), color: .black, linkedAtomIndexes: [32,  3]),
    AtomGraphicData(index: 33, name: "H", position: SCNVector3(x: -0.616, y: -1.048, z: -7.522), color: .black, linkedAtomIndexes: [33,  4]),
    AtomGraphicData(index: 34, name: "H", position: SCNVector3(x: -1.554, y: -0.952, z: -5.132), color: .black, linkedAtomIndexes: [34,  7]),
    AtomGraphicData(index: 35, name: "H", position: SCNVector3(x: 0.752,  y: 1.455, z: -1.563), color: .black, linkedAtomIndexes: [35, 11]),
    AtomGraphicData(index: 36, name: "H", position: SCNVector3(x: -2.678,  y: 0.312, z: -0.296), color: .black, linkedAtomIndexes: [36, 14]),
    AtomGraphicData(index: 37, name: "H", position: SCNVector3(x: -1.263,  y: 1.259, z:  0.221), color: .black, linkedAtomIndexes: [37, 14]),
    AtomGraphicData(index: 38, name: "H", position: SCNVector3(x: -2.275, y: -1.304, z:  1.550), color: .black, linkedAtomIndexes: [38, 15]),
    AtomGraphicData(index: 39, name: "H", position: SCNVector3(x: -2.651,  y: 1.649, z:  2.078), color: .black, linkedAtomIndexes: [39, 17]),
    AtomGraphicData(index: 40, name: "H", position: SCNVector3(x: -4.515,  y: 0.788, z:  3.094), color: .black, linkedAtomIndexes: [40, 18]),
    AtomGraphicData(index: 41, name: "H", position: SCNVector3(x: -1.646,  y: 1.537, z:  4.157), color: .black, linkedAtomIndexes: [41, 19]),
    AtomGraphicData(index: 42, name: "H", position: SCNVector3(x: -3.667,  y: 0.662, z:  4.867), color: .black, linkedAtomIndexes: [42, 20]),
    AtomGraphicData(index: 43, name: "H", position: SCNVector3(x: -1.119, y: -1.430, z:  3.931), color: .black, linkedAtomIndexes: [43, 21]),
    AtomGraphicData(index: 44, name: "H", position: SCNVector3(x: 1.334,  y: 1.357, z:  3.044), color: .black, linkedAtomIndexes: [44, 23]),
    AtomGraphicData(index: 45, name: "H", position: SCNVector3(x: 3.938,  y: 0.548, z:  8.562), color: .black, linkedAtomIndexes: [45, 27]),
    AtomGraphicData(index: 46, name: "H", position: SCNVector3(x: 4.015,  y: 1.303, z:  7.064), color: .black, linkedAtomIndexes: [46, 27]),
    AtomGraphicData(index: 47, name: "H", position: SCNVector3(x: 0.166, y: -2.014, z:  8.490), color: .black, linkedAtomIndexes: [4,  1, 33]),
  ]

  static let hydrogenSample = [
    AtomGraphicData(index: 0, name: "", position: SCNVector3(x: 1.200, y: -0.226, z: -6.850), color: .black, linkedAtomIndexes: [1]),
    AtomGraphicData(index: 1, name: "", position: SCNVector3(x: 1.740, y: 1.140, z: -6.672), color: .black, linkedAtomIndexes: [0]),
    AtomGraphicData(index: 2, name: "H", position: SCNVector3(x: -0.302, y: -0.139, z: -7.421), color: .black, linkedAtomIndexes: [0]),
  ]

  static let sample = [
    AtomGraphicData(index: 0, name: "", position: SCNVector3(x: 1.200, y: -0.226, z: -6.850), color: .black, linkedAtomIndexes: [1, 2, 4]),
    AtomGraphicData(index: 1, name: "", position: SCNVector3(x: 1.740, y: 1.140, z: -6.672), color: .black, linkedAtomIndexes: [4, 5]),
    AtomGraphicData(index: 2, name: "", position: SCNVector3(x: -0.302, y: -0.139, z: -7.421), color: .black, linkedAtomIndexes: [0, 3]),
    AtomGraphicData(index: 3, name: "", position: SCNVector3(x:  0.255, y: -0.130, z: -4.446), color: .black, linkedAtomIndexes: [2, 4]),
    AtomGraphicData(index: 4, name: "", position: SCNVector3(x:  0.810, y: 1.234, z: -4.304), color: .black, linkedAtomIndexes: [0, 1, 3, 5, 6]),
    AtomGraphicData(index: 5, name: "", position: SCNVector3(x: -1.231, y: -0.044, z: -5.057), color: .black, linkedAtomIndexes: [1, 4, 6]),
    AtomGraphicData(index: 6, name: "", position: SCNVector3(x:  1.192, y: -0.990, z: -5.433), color: .black, linkedAtomIndexes: [4, 5])
  ]

  static let square = [
    AtomGraphicData(index: 0, name: "", position: SCNVector3(x: 0, y: 0, z: 0), color: .black, linkedAtomIndexes: [1, 3]),
    AtomGraphicData(index: 1, name: "", position: SCNVector3(x: 0, y: 3, z: 0), color: .black, linkedAtomIndexes: [0, 2]),
    AtomGraphicData(index: 2, name: "", position: SCNVector3(x: 3, y: 3, z: 0), color: .black, linkedAtomIndexes: [1, 3]),
    AtomGraphicData(index: 3, name: "", position: SCNVector3(x: 3, y: 0, z: 0), color: .black, linkedAtomIndexes: [0, 2]),
  ]


  static let planSquare = [
    AtomGraphicData(index: 0, name: "", position: SCNVector3(x: 0, y: 0, z: 0), color: .black, linkedAtomIndexes: [1, 3]),
    AtomGraphicData(index: 1, name: "", position: SCNVector3(x: 0, y: 0, z: 3), color: .black, linkedAtomIndexes: [0, 2]),
    AtomGraphicData(index: 2, name: "", position: SCNVector3(x: 3, y: 0, z: 3), color: .black, linkedAtomIndexes: [1, 3]),
    AtomGraphicData(index: 3, name: "", position: SCNVector3(x: 3, y: 0, z: 0), color: .black, linkedAtomIndexes: [0, 2]),
  ]

  static let cube = [
    AtomGraphicData(index: 0, name: "", position: SCNVector3(x: 0, y: 0, z: 0), color: .black, linkedAtomIndexes: [1, 3, 4]),
    AtomGraphicData(index: 1, name: "", position: SCNVector3(x: 0, y: 3, z: 0), color: .black, linkedAtomIndexes: [0, 2, 5]),
    AtomGraphicData(index: 2, name: "", position: SCNVector3(x: 3, y: 3, z: 0), color: .black, linkedAtomIndexes: [1, 3, 6]),
    AtomGraphicData(index: 3, name: "", position: SCNVector3(x: 3, y: 0, z: 0), color: .black, linkedAtomIndexes: [0, 2, 7]),

    AtomGraphicData(index: 4, name: "", position: SCNVector3(x: 0, y: 0, z: 3), color: .black, linkedAtomIndexes: [0, 5, 7]),
    AtomGraphicData(index: 5, name: "", position: SCNVector3(x: 0, y: 3, z: 3), color: .black, linkedAtomIndexes: [1, 4, 6]),
    AtomGraphicData(index: 6, name: "", position: SCNVector3(x: 3, y: 3, z: 3), color: .black, linkedAtomIndexes: [2, 5, 7]),
    AtomGraphicData(index: 7, name: "", position: SCNVector3(x: 3, y: 0, z: 3), color: .black, linkedAtomIndexes: [3, 4, 6]),
  ]

  static let crossCube = [
    AtomGraphicData(index: 0, name: "", position: SCNVector3(x: 0, y: 0, z: 0), color: .black, linkedAtomIndexes: [1, 2, 3, 4, 5, 6, 7]),
    AtomGraphicData(index: 1, name: "", position: SCNVector3(x: 0, y: 5, z: 0), color: .black, linkedAtomIndexes: [0, 2, 3, 4, 5, 6, 7]),
    AtomGraphicData(index: 2, name: "", position: SCNVector3(x: 5, y: 5, z: 0), color: .black, linkedAtomIndexes: [0, 1, 3, 4, 5, 6, 7]),
    AtomGraphicData(index: 3, name: "", position: SCNVector3(x: 5, y: 0, z: 0), color: .black, linkedAtomIndexes: [0, 1, 2, 4, 5, 6, 7]),

    AtomGraphicData(index: 4, name: "", position: SCNVector3(x: 0, y: 0, z: 5), color: .black, linkedAtomIndexes: [0, 1, 2, 3, 5, 6, 7]),
    AtomGraphicData(index: 5, name: "", position: SCNVector3(x: 0, y: 5, z: 5), color: .black, linkedAtomIndexes: [0, 1, 2, 3, 4, 6, 7]),
    AtomGraphicData(index: 6, name: "", position: SCNVector3(x: 5, y: 5, z: 5), color: .black, linkedAtomIndexes: [0, 1, 2, 3, 4, 5, 7]),
    AtomGraphicData(index: 7, name: "", position: SCNVector3(x: 5, y: 0, z: 5), color: .black, linkedAtomIndexes: [0, 1, 2, 3, 4, 5, 6]),
  ]
}
