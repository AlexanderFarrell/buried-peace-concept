//
//  Furniture.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Furniture: DrawableEntity {
    override func setup() {
        let meshTry = setupMesh()
        
        if meshTry != nil
        {
            mesh = meshTry
        }
        
        let textureTry = setupTexture()
        
        if textureTry != nil
        {
            texture = textureTry
        }
        
        super.setup()
    }
    
    func setupMesh() -> REMesh?
    {
        return nil
    }
    
    func setupTexture() -> RETexture?
    {
        return nil
    }
}
