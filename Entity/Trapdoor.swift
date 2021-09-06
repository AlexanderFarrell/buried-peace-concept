//
//  Trapdoor.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/28/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Trapdoor: DrawableEntity {
    override func setup() {
        let tapResponder = ACTapResponder.init()
        self.beginComponent(component: tapResponder)
        
        self.name = "Trapdoor"
        
        self.mesh = ClayBox.makeBox(xCenter: 0.0, yCenter: 0.0, zCenter: 0.0, xLength: 4.0, yLength: 0.8, zLength: 4.0).getClayMesh(detail: 2).getMeshVertexPosTex(renderer: getRenderer())
        self.texture = RETexture.init(textureName: "ExitTexture", device: getRenderer().device)
        
        super.setup()
        
    }
    
    override func getInteractions() -> Set<InteractionTypesEntity>? {
        
        var retVal = Set<InteractionTypesEntity>()
        
        retVal.insert(.Travel)
        
        return retVal
    }
}
