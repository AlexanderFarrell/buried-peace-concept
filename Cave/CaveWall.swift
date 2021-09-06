//
//  CaveWall.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/27/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class CaveWall: NSObject {
    var xStart, yStart, baseStart, topStart: Float
    var xEnd, yEnd, baseEnd, topEnd: Float
    var textureIndex: Int = 0
    
    override init() {
        xStart = 0.0
        yStart = 0.0
        baseStart = 0.0
        topStart = 0.0
        xEnd = 0.0
        yEnd = 0.0
        baseEnd = 0.0
        topEnd = 0.0
    }
    
    
}
