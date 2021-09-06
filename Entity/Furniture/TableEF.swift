//
//  TableEF.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class TableEF: Furniture {
    var widthX: Float
    var widthZ: Float
    var height: Float
    var heightPlatformPer: Float = 0.8
    var widthXLeg: Float
    var widthZLeg: Float
    var generateQuadLegs: Bool
    
    init(widthXIn: Float, widthZIn: Float, heightIn: Float, widthXLegIn: Float, widthZLegIn: Float, generateQuadLegsIn: Bool) {
        widthX = widthXIn
        widthZ = widthZIn
        height = heightIn
        widthXLeg = widthXLegIn
        widthZLeg = widthZLegIn
        generateQuadLegs = generateQuadLegsIn
        
        super.init()
    }
    
    override func setupMesh() -> REMesh? {
        let platformHeight = height * (1.0 - heightPlatformPer)
        let platformYCenter = height * (1.0 - (heightPlatformPer/2.0))
        let legHeight = height * heightPlatformPer
        let legYCenter = height * (heightPlatformPer/2.0)
        
        let totalMesh = ClayMesh()
        
        //Create Platform
        let platformMesh = ClayBox.makeBox(xCenter: 0.0, yCenter: platformYCenter, zCenter: 0.0, xLength: widthX, yLength: platformHeight, zLength: widthZ).getClayMesh(detail: 2)
        totalMesh.addMeshToMesh(mesh: platformMesh)
        
        //Create Legs
        if generateQuadLegs
        {
            let legXStart = ((widthX/2.0) - (widthXLeg/2.0))
            let legZStart = ((widthZ/2.0) - (widthZLeg/2.0))
            
            let topLeft = ClayBox.makeBox(xCenter: -legXStart, yCenter: legYCenter, zCenter: -legZStart, xLength: widthXLeg, yLength: legHeight, zLength: widthZLeg)
            topLeft.textureCoordinateSynthesis = .WorldTCCM
            totalMesh.addMeshToMesh(mesh: topLeft.getClayMesh(detail: 2))
            
            let topRight = ClayBox.makeBox(xCenter: legXStart, yCenter: legYCenter, zCenter: -legZStart, xLength: widthXLeg, yLength: legHeight, zLength: widthZLeg)
            topRight.textureCoordinateSynthesis = .WorldTCCM
            totalMesh.addMeshToMesh(mesh: topRight.getClayMesh(detail: 2))
            
            let bottomLeft = ClayBox.makeBox(xCenter: -legXStart, yCenter: legYCenter, zCenter: legZStart, xLength: widthXLeg, yLength: legHeight, zLength: widthZLeg)
            bottomLeft.textureCoordinateSynthesis = .WorldTCCM
            totalMesh.addMeshToMesh(mesh: bottomLeft.getClayMesh(detail: 2))
            
            let bottomRight = ClayBox.makeBox(xCenter: legXStart, yCenter: legYCenter, zCenter: legZStart, xLength: widthXLeg, yLength: legHeight, zLength: widthZLeg)
            bottomRight.textureCoordinateSynthesis = .WorldTCCM
            totalMesh.addMeshToMesh(mesh: bottomRight.getClayMesh(detail: 2))
        }
        else
        {
            let topLeft = ClayBox.makeBox(xCenter: widthXLeg/2.0, yCenter: legYCenter, zCenter: widthZLeg/2.0, xLength: widthXLeg, yLength: legHeight, zLength: widthZLeg)
            topLeft.textureCoordinateSynthesis = .WorldTCCM
            totalMesh.addMeshToMesh(mesh: topLeft.getClayMesh(detail: 2))
        }
        
        return totalMesh.getMeshVertexPosTex(renderer: getRenderer())
    }
    
    override func setupTexture() -> RETexture? {
        var retValTexture: RETexture
        
        let valueStrength = getRandomMicro().nextFloatInRange(minValue: 0.3, maxValue: 0.75)
        
        let clayImage = ClayImage.init(red: valueStrength, green: valueStrength, blue: valueStrength, alpha: 1.0)
        
        retValTexture = RETexture.init(clayImage: clayImage, renderer: getRenderer(), mipmapped: false)
        
        return retValTexture
    }
    
    /*
     let valueStrength = getRandomMicro().nextFloatInRange(minValue: 0.3, maxValue: 0.75)
     var clayImage = ClayImage.init(width: 8, height: 8)
     
     var ix = 0
     
     while ix < clayImage.Width
     {
     var iy = 0
     
     while iy < clayImage.Height
     {
     let localValue = valueStrength + random.nextFloatMaxValue(maxValue: 0.2)
 */
}
