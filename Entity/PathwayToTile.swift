//
//  PathwayToTile.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/4/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class PathwayToTile: DrawableEntity {
    var direction: Int = 0
    
    override func setup() {
        setupMesh()
        
        self.name = "Travel"
        
        switch direction
        {
        case 0:
            self.name = "West Exit"
            break
        case 1:
            self.name = "East Exit"
            break
        case 2:
            self.name = "North Exit"
            break
        case 3:
            self.name = "South Exit"
            break
        default:
            self.name = "Unknown Exit"
            break
        }
        
        let microWorld = getMicroWorld()
        
        if microWorld.playerStartDirection == direction
        {
            let player = microWorld.entityEngine.player
            
            player!.x = self.x
            player!.z = self.z
            
            switch direction
            {
            case 0:
                player!.x += Float(3.0)
                break
            case 1:
                player!.x -= Float(3.0)
                break
            case 2:
                player!.z += Float(3.0)
                break
            case 3:
                player!.z -= Float(3.0)
                break
            default:
                break
            }
        }
    }
    
    func setupMesh()
    {
        //texture = RETexture.init(clayImage: ClayImage.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0), renderer: getRenderer(), mipmapped: false)
        mesh = ClayBox.makeBox(xCenter: 0.0, yCenter: size/2, zCenter: 0.0, xLength: size, yLength: size, zLength: size).getClayMesh(detail: 3).getMeshVertexPosTex(renderer: getRenderer())
        
        let solidObject = ACSolidEntity()
        solidObject.boundingRadius = size
        
        self.beginComponent(component: solidObject)
        
        let textureManager = getTextureManager()
        
        if !textureManager.hasTextureAt(name: 7)
        {
            let textureBuffer = RETexture.init(textureName: "ExitTexture", device: getRenderer().device)
            
            textureManager.addTexture(texture: textureBuffer, name: 7)
        }
        
        texture = textureManager.texturesByName[7]
        
        let tapResponder = ACTapResponder()
        self.beginComponent(component: tapResponder)
        
        
        
        super.setup()
    }
    
    override func getInteractions() -> Set<InteractionTypesEntity>? {
        
        var retVal = Set<InteractionTypesEntity>()
        
        retVal.insert(.Travel)
        
        return retVal
    }
}
