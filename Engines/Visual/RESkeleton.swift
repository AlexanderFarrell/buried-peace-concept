//
//  RESkeleton.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/20/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class RESkeleton: NSObject {
    var BufferBones: REBuffer
    var BoneCount: Int = 0
    
    static let boneMaxCount = 20
    
    init(renderer: Renderer) {
        var matrixData = [Float]()
        
        var iMatrix = 0
        
        while iMatrix < RESkeleton.boneMaxCount
        {
            iMatrix += 1
            
            matrixData.append(contentsOf: [Float].init(repeating: 0.0, count: 16))
        }
        
        let matrixDataSize = MSCMathHelper.dataSizeOfArray(data: matrixData)
        
        BufferBones = REBuffer.init(device: renderer.device, bytes: matrixData, length: matrixDataSize)
    }
    
    init(renderer: Renderer, camera: RECamera) {
        var matrixData = [Float]()
        
        var iMatrix = 0
        
        while iMatrix < RESkeleton.boneMaxCount
        {
            iMatrix += 1
            
            matrixData.append(contentsOf: [Float].init(repeating: 0.0, count: 16))
        }
        
        let matrixDataSize = MSCMathHelper.dataSizeOfArray(data: matrixData)
        
        BufferBones = REBuffer.init(device: renderer.device, bytes: matrixData, length: matrixDataSize)
    }
    
    func UpdateValue(matrices: [TDMatrix4], camera: RECamera) {
        
        assert(matrices.count > 0, "Matrices cannot have a count of 0")
        
        let maxBones = RESkeleton.boneMaxCount
        var matrixData = [Float]()
        
        BoneCount = (matrices.count < (maxBones + 1)) ? matrices.count : maxBones
        
        var iMatrix = 0
        
        while iMatrix < maxBones
        {
            iMatrix += 1
            
            if iMatrix < matrices.count
            {
                let transformMatrix = RETransformMVP.GetTransformMatrix(worldMatrix: matrices[iMatrix], camera: camera)
                let localMatrixData = MSCMathHelper.matrix4ToArray(matrix: transformMatrix)
                
                matrixData.append(contentsOf: localMatrixData)
            }
            else
            {
                matrixData.append(contentsOf: [Float].init(repeating: 0.0, count: 16))
            }
        }
        
        let matrixDataSize = MSCMathHelper.dataSizeOfArray(data: matrixData)
        
        BufferBones.updateValue(bytes: matrixData, length: matrixDataSize)
    }
    
    
    
    func UpdateValueOrtho(matrices: [TDMatrix4], camera: REOrthoCamera) {
        
        assert(matrices.count > 0, "Matrices cannot have a count of 0")
        
        let maxBones = RESkeleton.boneMaxCount
        var matrixData = [Float]()
        
        BoneCount = (matrices.count < (maxBones + 1)) ? matrices.count : maxBones
        
        var iMatrix = 0
        
        while iMatrix < maxBones
        {
            iMatrix += 1
            
            if iMatrix < matrices.count
            {
                let transformMatrix = RETransformMVP.GetTransformMatrixOrtho(worldMatrix: matrices[iMatrix], camera: camera)
                let localMatrixData = MSCMathHelper.matrix4ToArray(matrix: transformMatrix)
                
                matrixData.append(contentsOf: localMatrixData)
            }
            else
            {
                matrixData.append(contentsOf: [Float].init(repeating: 0.0, count: 16))
            }
        }
        
        let matrixDataSize = MSCMathHelper.dataSizeOfArray(data: matrixData)
        
        BufferBones.updateValue(bytes: matrixData, length: matrixDataSize)
    }
    
    func ActiveBuffer() -> MTLBuffer {
        return BufferBones.getBufferActive()
    }
    
    func Delete()
    {
        BufferBones.deleteBuffer()
    }
    
    class func GetTransformMatrix(worldMatrix: TDMatrix4, camera: RECamera) -> TDMatrix4 {
        let worldMatrix = worldMatrix
        let viewMatrix = camera.ViewMatrix
        let projectionMatrix = camera.ProjectionMatrix
        
        let transformMatrix = TDMatrix4Multiply(projectionMatrix!, TDMatrix4Multiply(viewMatrix!, worldMatrix))
        
        return transformMatrix
    }
    
    class func GetTransformMatrixOrtho(worldMatrix: TDMatrix4, camera: REOrthoCamera) -> TDMatrix4 {
        let worldMatrix = worldMatrix
        let viewMatrix = camera.ViewMatrix
        let projectionMatrix = camera.ProjectionMatrix
        
        let transformMatrix = TDMatrix4Multiply(projectionMatrix!, TDMatrix4Multiply(viewMatrix!, worldMatrix))
        
        return transformMatrix
    }
    
    deinit {
        //Delete()
    }

}
