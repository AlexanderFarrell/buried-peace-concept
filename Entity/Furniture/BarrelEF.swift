//
//  BarrelEF.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class BarrelEF: Furniture {
    var radius: Float
    var height: Float
    
    init(radiusIn: Float, heightIn: Float) {
        radius = radiusIn
        height = heightIn
        
        super.init()
    }
    
    override func setupMesh() -> REMesh? {
        var retVal: REMesh
        
        retVal = ClayGeometry.CreateCylinderYClosed(azimuthDetail: 5, heightDetail: 1, radialDetail: 1, radius: radius, height: height).getMeshVertexPosTex(renderer: getRenderer())
        
        return retVal
    }
    
    override func setupTexture() -> RETexture? {
        var retValTexture: RETexture
        
        let valueStrength = getRandomMicro().nextFloatInRange(minValue: 0.3, maxValue: 0.75)
        
        let clayImage = ClayImage.init(red: valueStrength, green: valueStrength, blue: valueStrength, alpha: 1.0)
        
        retValTexture = RETexture.init(clayImage: clayImage, renderer: getRenderer(), mipmapped: false)
        
        return retValTexture
    }
}
