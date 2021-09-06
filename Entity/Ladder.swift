//
//  Ladder.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/29/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Ladder: DrawableEntity {
    override func setup() {
        let tapResponder = ACTapResponder.init()
        self.beginComponent(component: tapResponder)
        
        self.name = "Ladder"
        
        self.mesh = getLadderMesh()//ClayBox.makeBox(xCenter: 0.0, yCenter: 0.0, zCenter: 0.0, xLength: 4.0, yLength: 0.8, zLength: 4.0).getClayMesh(detail: 2).getMeshVertexPosTex(renderer: getRenderer())
        self.texture = RETexture.init(textureName: "ExitTexture", device: getRenderer().device)
        
        self.yaw = getRandomMicro().nextFloatMaxValue(maxValue: Float.pi * 2.0)
        
        super.setup()
        
    }
    
    func getLadderMesh() -> REMesh
    {
        let handleCount: Int = 10
        let height: Float = 7.0
        let handleHeight: Float = 0.2
        let railDiameter: Float = 0.3
        let handleWidth: Float = 0.8
        let handleForwardWidth: Float = 0.25
        
        let leftRailClayMeshBox = ClayBox.makeBox(xCenter: -handleWidth/2.0, yCenter: height/2.0, zCenter: 0.0, xLength: railDiameter, yLength: height, zLength: railDiameter)
        let rightRailClayMeshBox = ClayBox.makeBox(xCenter: handleWidth/2.0, yCenter: height/2.0, zCenter: 0.0, xLength: railDiameter, yLength: height, zLength: railDiameter)
        
        leftRailClayMeshBox.textureCoordinateSynthesis = .WorldTCCM
        rightRailClayMeshBox.textureCoordinateSynthesis = .WorldTCCM
        
        let leftRailClayMesh = leftRailClayMeshBox.getClayMesh(detail: 2)
        let rightRailClayMesh = rightRailClayMeshBox.getClayMesh(detail: 2)
        
        let masterClayMesh = ClayMesh()
        masterClayMesh.addMeshToMesh(mesh: leftRailClayMesh)
        masterClayMesh.addMeshToMesh(mesh: rightRailClayMesh)
        
        var iHandle = 0
        
        while iHandle < handleCount
        {
            let handleMeshBox = ClayBox.makeBox(xCenter: 0.0, yCenter: height * (Float(iHandle)/Float(handleCount)), zCenter: 0.0, xLength: handleWidth, yLength: handleHeight, zLength: handleForwardWidth)
            let handleMesh = handleMeshBox.getClayMesh(detail: 2)
            
            masterClayMesh.addMeshToMesh(mesh: handleMesh)
            
            iHandle += 1
        }
        
        return masterClayMesh.getMeshVertexPosTex(renderer: getRenderer())
    }
    
    override func getInteractions() -> Set<InteractionTypesEntity>? {
        
        var retVal = Set<InteractionTypesEntity>()
        
        retVal.insert(.Travel)
        
        return retVal
    }

}
