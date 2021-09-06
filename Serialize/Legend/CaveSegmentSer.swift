//
//  CaveSegmentSer.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 2/14/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

struct CaveSegmentSer: Codable {
    var xInSquares: Int = 0
    var yInSquares: Int = 0
    var xInSegments: Int = 0
    var yInSegments: Int = 0
    var squares: [CaveSquareSer] = [CaveSquareSer]()
    var layers: [CaveSquareLayerSer] = [CaveSquareLayerSer]()
    var floorHeightMap: ClayHeightMapSerializable = ClayHeightMapSerializable.init(altitude: [[Float]]())
    var ceilHeightMap: ClayHeightMapSerializable = ClayHeightMapSerializable.init(altitude: [[Float]]())
}
