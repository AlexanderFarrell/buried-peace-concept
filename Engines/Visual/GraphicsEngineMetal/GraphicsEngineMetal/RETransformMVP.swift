//
//  RETransformMVP.swift
//  SpelunkingSwift
//
//  Created by Alexander Farrell on 5/13/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit
import Metal

class RETransformMVP: NSObject {
    var BufferedTransform: REBuffer?
    
    init(device: MTLDevice) {
        let transformMatrix = TDMatrix4Identity
        
        let matrixData = MSCMathHelper.matrix4ToArray(matrix: transformMatrix)
        let matrixDataSize = MSCMathHelper.dataSizeOfArray(data: matrixData)
        
        BufferedTransform = REBuffer.init(device: device, bytes: matrixData, length: matrixDataSize)
    }
    
    init(device: MTLDevice, camera: RECamera) {
        let transformMatrix = RETransformMVP.GetTransformMatrix(worldMatrix: TDMatrix4Identity, camera: camera)
        
        let matrixData = MSCMathHelper.matrix4ToArray(matrix: transformMatrix)
        let matrixDataSize = MSCMathHelper.dataSizeOfArray(data: matrixData)
        
        BufferedTransform = REBuffer.init(device: device, bytes: matrixData, length: matrixDataSize)
    }
    
    func UpdateValue(worldMatrix: TDMatrix4, camera: RECamera) {
        let transformMatrix = RETransformMVP.GetTransformMatrix(worldMatrix: worldMatrix, camera: camera)
        
        let matrixData = MSCMathHelper.matrix4ToArray(matrix: transformMatrix)
        let matrixDataSize = MSCMathHelper.dataSizeOfArray(data: matrixData)
        
        BufferedTransform?.updateValue(bytes: matrixData, length: matrixDataSize)
    }
    
    func UpdateValueOrtho(worldMatrix: TDMatrix4, camera: REOrthoCamera)
    {
        let transformMatrix = RETransformMVP.GetTransformMatrixOrtho(worldMatrix: worldMatrix, camera: camera)
        
        let matrixData = MSCMathHelper.matrix4ToArray(matrix: transformMatrix)
        let matrixDataSize = MSCMathHelper.dataSizeOfArray(data: matrixData)
        
        BufferedTransform?.updateValue(bytes: matrixData, length: matrixDataSize)
    }
    
    func ActiveBuffer() -> MTLBuffer {
        return BufferedTransform?.getBufferActive as! MTLBuffer
    }
    
    func Delete()
    {
        BufferedTransform?.deleteBuffer()
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
