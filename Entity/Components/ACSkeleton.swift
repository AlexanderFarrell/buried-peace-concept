//
//  ACSkeleton.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/20/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ACSkeleton: AgentComponent {
    var bufferedSkeleton: RESkeleton!
    var bonePositions = [TDVector3]()
    var boneRotations = [TDQuaternion]()
    
    private var mesh: REMesh
    {
        get {
            return (self.entityDelegate.getEntityHost() as! DrawableEntity).mesh
        }
    }
    private var texture: RETexture
    {
        get {
            return (self.entityDelegate.getEntityHost() as! DrawableEntity).texture
        }
    }
    
    var globalPosition: TDVector3
    {
        get {
            return self.entityDelegate.getEntityHost().Position()
        }
    }
    
    override func begin() {
        bufferedSkeleton = RESkeleton.init(renderer: getRenderer(), camera: getActiveCamera())
        
        //Subscribe to custom draw
        if self.entityDelegate.getEntityHost() is DrawableEntity
        {
            (self.entityDelegate.getEntityHost() as! DrawableEntity).customDrawSubscriber = self
        }
        
        super.begin()
    }
    
    override func end() {
        
        //Unsubscribe to custom draw
        if self.entityDelegate.getEntityHost() is DrawableEntity
        {
            if (self.entityDelegate.getEntityHost() as! DrawableEntity).customDrawSubscriber === self //Only unsubscribe if this ACSkeleton is the custom drawer
            {
                (self.entityDelegate.getEntityHost() as! DrawableEntity).customDrawSubscriber = nil
            }
        }
        
        super.end()
    }
    
    override func breakdown() {
        self.end()
    }
    
    func getTransforms() -> [TDMatrix4]
    {
        var iPosRot = 0
        var retValMatrices = [TDMatrix4]()
        
        while iPosRot < bonePositions.count
        {
            let position = bonePositions[iPosRot]
            let rotation = boneRotations[iPosRot]
            
            let worldPosition = TDVector3Add(position, globalPosition)
            
            var worldMatrix = TDMatrix4Identity
            
            worldMatrix = TDMatrix4Multiply(worldMatrix, TDMatrix4MakeTranslation(worldPosition.v.0, worldPosition.v.1, worldPosition.v.2))
                                              worldMatrix = TDMatrix4Multiply(worldMatrix, TDMatrix4MakeWithQuaternion(rotation))
            
            retValMatrices.append(worldMatrix)//(RESkeleton.GetTransformMatrix(worldMatrix: worldMatrix, camera: getActiveCamera()))
            
            iPosRot += 1
        }
        
        return retValMatrices
    }
    
    override func draw() {
        
        
        bufferedSkeleton.UpdateValue(matrices: getTransforms(), camera: getActiveCamera())
        
        let renderer = getRenderer()
        renderer.setRenderPipelineState(identifier: "Skeleton")
        renderer.setTexture(texture: texture)
        renderer.setVertexBuffer(buffer: (bufferedSkeleton.BufferBones.getBufferActive()), index: 1)
        renderer.setFragmentBuffer(buffer: getCave().ambientColorBuffer.getBufferActive(), index: 2)
        renderer.setFragmentBuffer(buffer: getCave().directionalLightPositionBuffer.getBufferActive(), index: 3)
        renderer.drawMesh(mesh: mesh)
    }
    
    override class func componentName() -> String {
        return "Skeleton"
    }
    
    /*
 
     
     func worldMatrix() -> TDMatrix4 {
     var retVal: TDMatrix4!
     
     retVal = TDMatrix4Identity
     
     retVal = TDMatrix4Multiply(retVal, TDMatrix4MakeTranslation(x, y, z))
     retVal = TDMatrix4Multiply(retVal, TDMatrix4MakeYRotation(yaw))
     
     return retVal
     }
 */
}
