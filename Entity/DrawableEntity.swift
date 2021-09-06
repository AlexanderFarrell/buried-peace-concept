//
//  DrawableEntity.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/27/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class DrawableEntity: Entity {
    var mesh: REMesh!
    var texture: RETexture!
    var transform: RETransformMVP!
    var visible: Bool! = true
    var uniqueTexture = false
    var size: Float = 0.0
    var customDrawSubscriber: AgentComponent? = nil
    
    override func setup() {
        let renderer = self.gameplayDelegate.getRenderer()
        
        transform = RETransformMVP.init(device: renderer.device)
        
        /*if macroIdentity != nil
        {
            self.mesh = macroIdentity!.generateMesh()
            self.texture = macroIdentity!.generateTexture()
        }*/
        
        super.setup()
    }
    
    override func breakdown() {
        super.breakdown()
        
        if mesh != nil
        {
            mesh.deleteMesh()
            mesh = nil
        }
        
        if (texture != nil) && (uniqueTexture)
        {
            texture.Delete()
            texture = nil
        }
        
        if transform != nil
        {
            transform.Delete()
            transform = nil
        }
    }
    
    override func update() {
        super.update()
        
        isEntityInFrustum = self.gameplayDelegate.getActiveCamera().isPointInFrustum(point: Position(), drawDistance: 300.0)
    }
    
    override func draw() {
        if visible {
            if isEntityInFrustum || frustumCullingExempt
            {
                if customDrawSubscriber == nil
                {
                    transform.UpdateValue(worldMatrix: self.worldMatrix(), camera: self.gameplayDelegate.getActiveCamera())
                    
                    let renderer = getRenderer()
                    if renderer.currentRenderPiplineIdentifier != "Default"
                    {
                        renderer.setRenderPipelineState(identifier: "Default")
                    }
                    
                    
                    if texture != nil{
                        renderer.setTexture(texture: texture)
                    }
                    /*else
                     {
                     renderer.setTexture(texture: eeDelegate.getGenericTexture())
                     }*/
                    
                    renderer.setVertexBuffer(buffer: (transform.BufferedTransform?.getBufferActive())!, index: 1)
                    renderer.drawMesh(mesh: mesh)
                }
                else
                {
                    customDrawSubscriber!.draw()
                }
            }
        }
    }
    
    /*func worldMatrix() -> TDMatrix4 {
        var retVal: TDMatrix4!
        
        retVal = TDMatrix4Identity
        
        retVal = TDMatrix4Multiply(retVal, TDMatrix4MakeTranslation(x, y, z))
        retVal = TDMatrix4Multiply(retVal, TDMatrix4MakeYRotation(yaw))
        
        return retVal
    }
    
    func Position() -> TDVector3
    {
        return TDVector3Make(x, y, z)
    }
    
    func setPositionWithVector(vector: TDVector3)
    {
        x = vector.v.0
        y = vector.v.1
        z = vector.v.2
    }*/
}
