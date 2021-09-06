//
//  TextureManager.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class TextureManager: GameplayObject {
    var counter = 0
    var texturesByName = Dictionary<Int, RETexture>()
    var textures = Set<RETexture>()
    
    private var nameByTextures = Dictionary<RETexture, Int>()
    
    func addTexture(texture: RETexture) -> Int
    {
        let index = counter
        counter += 1
        
        texturesByName[index] = texture
        textures.insert(texture)
        nameByTextures[texture] = index
        
        return index
    }
    
    func addTexture(texture: RETexture, name: Int)
    {
        assert(texturesByName[name] == nil, "Texture has already been buffered with the unique identifier: " + String(name) + ". Killing DEBUG application.")
        
        texturesByName[name] = texture
        textures.insert(texture)
        nameByTextures[texture] = name
    }
    
    func hasTextureAt(name: Int) -> Bool
    {
        return (texturesByName[name] != nil)
    }
    
    func removeTexture(name: Int)
    {
        let texture = texturesByName[name]
        
        if texture != nil
        {
            nameByTextures[texture!] = nil
            
            textures.remove(texture!)
            
            texturesByName[name]?.Delete()
            texturesByName[name] = nil
        }
    }
    
    func removeTexture(texture: RETexture)
    {
        let name = nameByTextures[texture]
        
        if name != nil
        {
            nameByTextures[texture] = nil
            
            textures.remove(texture)
            
            texturesByName[name!]?.Delete()
            texturesByName[name!] = nil
            
        }
    }
    
    override func breakdown() {
        for texture in textures
        {
            texture.Delete()
        }
        
        nameByTextures.removeAll()
        texturesByName.removeAll()
        textures.removeAll()
    }
}
