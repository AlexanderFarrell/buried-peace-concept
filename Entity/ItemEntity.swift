//
//  ItemEntity.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ItemEntity: DrawableEntity {
    var item: InventoryItem!
    
    override func setup() {
        setupMesh()
        setupTexture()
        
        self.name = item.typeInv.name
        
        if item.typeInv.weapon != nil
        {
            item.typeInv.weapon?.registerProjectiles(projectileAssetManager: getEntityEngine().projectileAssetManager, renderer: getRenderer())
            //Clean these up if they arent picked up.
        }
        
        let tapResponder = ACTapResponder()
        self.beginComponent(component: tapResponder)
        
        super.setup()
    }
    
    override func getInteractions() -> Set<InteractionTypesEntity>? {
        var retVal = Set<InteractionTypesEntity>()
        retVal.insert(.Pickup)
        return retVal
    }
    
    func setupMesh()
    {
        let clayMesh = ClayGeometry.createUVSphere(latitudeLines: 5, longitudeLines: 5, radius: 0.2)
        clayMesh.translateVertices(translation: TDVector3Make(0.0, 0.1, 0.0))
        
        mesh = clayMesh.getMeshVertexPosTex(renderer: getRenderer())
    }
    
    func setupTexture()
    {
        let clayImage = ClayImage.init(red: getRandomMicro().nextFloatUnit(), green: getRandomMicro().nextFloatUnit(), blue: getRandomMicro().nextFloatUnit(), alpha: 1.0)
        
        texture = RETexture.init(clayImage: clayImage, renderer: getRenderer(), mipmapped: false)
    }
}
