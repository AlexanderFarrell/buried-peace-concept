//
//  CrateEF.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class CrateEF: Furniture {
    var xSize, ySize, zSize: Float
    
    init(xSizeIn: Float, ySizeIn: Float, zSizeIn: Float) {
        xSize = xSizeIn
        ySize = ySizeIn
        zSize = zSizeIn
        
        super.init()
    }
    
    override func setupMesh() -> REMesh? {
        var retVal: REMesh
        
        retVal = ClayBox.makeBox(xCenter: 0.0, yCenter: ySize/2.0, zCenter: 0.0, xLength: xSize, yLength: ySize, zLength: zSize).getClayMesh(detail: 2).getMeshVertexPosTex(renderer: getRenderer())
        
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
