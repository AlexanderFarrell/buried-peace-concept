//
//  MacroPersonality.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum MacroPersonalityType {
    case Human
    case Boss
    case NotSet
    case Miniboss
}

class MacroPersonality: GameplayObject, NSCoding {
    
    var name: String = "Nameless"
    var xLocation: Int = 0
    var yLocation: Int = 0
    var layerLocation: Int = 0
    var typeMP: MacroPersonalityType = MacroPersonalityType.NotSet
    var story = [String]()
    
    //Inventory
    
    
    //Assignments
    
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "Name") as! String
    }
    
    func getDrawableEntity() -> DrawableEntity
    {
        let drawableEntity = DrawableEntity.init()
        
        drawableEntity.mesh = generateMesh()
        drawableEntity.texture = generateTexture()
        
        return drawableEntity
    }
    
    func generateMesh() -> REMesh
    {
        return ClayBox.makeBox(xCenter: 0.0, yCenter: 1.5, zCenter: 0.0, xLength: 1.0, yLength: 1.0, zLength: 1.0).getClayMesh(detail: 2).getMeshVertexPosTex(renderer: getRenderer())
    }
    
    func generateTexture() -> RETexture
    {
        return RETexture.init(clayImage: ClayImage.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0), renderer: getRenderer(), mipmapped: false)
    }
}
