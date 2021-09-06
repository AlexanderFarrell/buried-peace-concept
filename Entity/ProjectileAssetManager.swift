//
//  ProjectileAssetManager.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ProjectileAssetManager: GameplayObject {
    private var data = Dictionary<String, (mesh: REMesh, texture: RETexture)>()
    
    func registerProjectile(identifier: String, mesh: REMesh, texture: RETexture)
    {
        data[identifier] = (mesh: mesh, texture: texture)
    }
    
    func unregisterProjectile(identifier: String)
    {
        if let item = data[identifier]
        {
            item.mesh.deleteMesh()
            item.texture.Delete()
        }
        
        data[identifier] = nil
    }
    
    func getTextureFor(identifier: String) -> RETexture?
    {
        let item = data[identifier]
        
        return item?.texture
    }
    
    func getMeshFor(identifier: String) -> REMesh?
    {
        let item = data[identifier]
        
        return item?.mesh
    }
}
