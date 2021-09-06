//
//  CaveSquareSer.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/31/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

struct CaveSquareSer: Codable {
    var x: Int = 0
    var y: Int = 0
    
    var floorAltitudex0y0: Float = 0.0
    var floorAltitudex1y0: Float = 0.0
    var floorAltitudex0y1: Float = 0.0
    var floorAltitudex1y1: Float = 0.0
    
    var ceilingAltitudex0y0: Float = 20.0
    var ceilingAltitudex1y0: Float = 20.0
    var ceilingAltitudex0y1: Float = 20.0
    var ceilingAltitudex1y1: Float = 20.0
    
    var wallFloorToCeilIndex: Int = 0
    var wallExceptionIndex: Int = 0
    
    var floorTexture: Int = 0
    var ceilTexture: Int = 0
}
