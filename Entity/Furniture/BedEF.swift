//
//  BedEF.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class BedEF: Furniture {
    var xSize, ySize, zSize: Float
    var pillowXPer: Float = 0.8
    var pillowZStartPer: Float = 0.05
    var pillowZEndPer: Float = 0.2
    var pillowThickness: Float = 0.05
    
    init(xSizeIn: Float, ySizeIn: Float, zSizeIn: Float) {
        xSize = xSizeIn
        ySize = ySizeIn
        zSize = zSizeIn
        
        super.init()
    }
    
    override func setupMesh() -> REMesh? {
        var retVal: REMesh
        
        let matressMesh = ClayBox.makeBox(xCenter: 0.0, yCenter: ySize/2.0, zCenter: 0.0, xLength: xSize, yLength: ySize, zLength: zSize).getClayMesh(detail: 2)
        
        let pillowXSize = xSize * pillowXPer
        let pillowYSize = pillowThickness
        let pillowZSize = zSize * (pillowZEndPer - pillowZStartPer)
        let pillowX: Float = 0.0
        let pillowY = (ySize/2.0) + (pillowThickness/2.0)
        let pillowZ = (zSize * ((pillowZEndPer + pillowZStartPer)/2.0 - pillowZStartPer)) - (zSize/2.0)
        
        let pillowMesh = ClayBox.makeBox(xCenter: pillowX, yCenter: pillowY, zCenter: pillowZ, xLength: pillowXSize, yLength: pillowYSize, zLength: pillowZSize).getClayMesh(detail: 2)
        
        let totalMesh = ClayMesh()
        totalMesh.addMeshToMesh(mesh: matressMesh)
        totalMesh.addMeshToMesh(mesh: pillowMesh)
        
        retVal = totalMesh.getMeshVertexPosTex(renderer: getRenderer())
        
        return retVal
    }
    
    override func setupTexture() -> RETexture? {
        var retValTexture: RETexture
        
        let valueStrength = getRandomMicro().nextFloatInRange(minValue: 0.3, maxValue: 0.75)
        
        let clayImage = ClayImage.init(red: valueStrength * 0.9, green: valueStrength * 0.5, blue: valueStrength * 0.1, alpha: 1.0)
        
        retValTexture = RETexture.init(clayImage: clayImage, renderer: getRenderer(), mipmapped: false)
        
        return retValTexture
    }
}
