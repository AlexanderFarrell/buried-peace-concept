//
//  TargetCube.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/4/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class TargetCube: DrawableEntity {
    override func setup() {
        self.visible = true
        
        let clayBox = ClayBox.makeBox(xCenter: 0, yCenter: 0, zCenter: 0, xLength: 2, yLength: 2, zLength: 2)
        self.mesh = clayBox.getMesh(detail: 2, device: self.gameplayDelegate.getRenderer().device)
        
        //self.texture = RETexture.init(textureName: "Robotic001", device: self.gameplayDelegate.getRenderer().device)
        createTexture()
        
        isDeleted = false
        
        frustumCullingExempt = true
        super.setup()
    }
    
    func createMesh()
    {
        
    }
    
    func createTexture()
    {
        var clayImage = ClayImage.init(width: 16, height: 16)
        clayImage = ClayImageFilters.ClearImage(image: clayImage, red: 0.0, green: 0.3, blue: 0.6)
        
        var ix = 0
        
        while ix < clayImage.Width
        {
            var iy = 0
            
            while iy < clayImage.Height
            {
                if ((iy + ix) % 4) == 0
                {
                    clayImage.setPixelAt(x: ix, y: iy, pixel: PixelRGBA.init(r: 0.0, g: 0.5, b: 1.0, a: 1.0))
                }
                
                iy += 1
            }
            
            ix += 1
        }
        
        texture = RETexture.init(clayImage: clayImage, renderer: getRenderer(), mipmapped: true)//RETexture.init(cgImage: clayImage.getCGImage8BitColorMetal(), device: getRenderer().device
    }
    
    override func update() {
        let playerTargeter = self.gameplayDelegate.getEntityEngine().player.components[ACTargeter.componentName()] as! ACTargeter
        
        if playerTargeter.hasTarget()
        {
            let target = playerTargeter.target
            
            self.visible = true
            self.x = (target?.x)!
            self.y = (target?.y)! + 5
            self.z = (target?.z)!
            self.yaw = (target?.yaw)!
        }
        else
        {
            self.visible = false
        }
        
        
        super.update()
    }
}
