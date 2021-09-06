//
//  CrateObstacle.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class CrateObstacle: DrawableEntity {
    
    override func setup() {
        //texture = RETexture.init(clayImage: ClayImage.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0), renderer: getRenderer(), mipmapped: false)
        mesh = ClayBox.makeBox(xCenter: 0.0, yCenter: size/2, zCenter: 0.0, xLength: size, yLength: size, zLength: size).getClayMesh(detail: 3).getMeshVertexPosTex(renderer: getRenderer())
        
        let solidObject = ACSolidEntity()
        solidObject.boundingRadius = size
        
        self.beginComponent(component: solidObject)
        
        let textureManager = getTextureManager()
        
        if !textureManager.hasTextureAt(name: 8)
        {
            let textureBuffer = RETexture.init(textureName: "Tile003", device: getRenderer().device)
            
            textureManager.addTexture(texture: textureBuffer, name: 8)
        }
        
        texture = textureManager.texturesByName[8]
        
        //let tapResponder = ACTapResponder()
        //self.beginComponent(component: tapResponder)
        
        self.name = "Crate"
        
        super.setup()
    }
}
