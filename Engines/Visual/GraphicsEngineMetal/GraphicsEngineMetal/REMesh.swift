//
//  REMesh.swift
//  GraphicsEngineMetal
//
//  Created by Alexander Farrell on 6/5/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class REMesh: NSObject {
    var vertexBuffer: MTLBuffer!
    var indexBuffer:  MTLBuffer!
    
    var released: Bool = false;
    
    var indexCount: Int;
    var primitiveCount: Int;
    
    init(vertexPositionColors: [VertexPosCol], indices: [UInt32], device: MTLDevice) {
        
        let vertexDataSize = vertexPositionColors.count * MemoryLayout.size(ofValue: vertexPositionColors[0])
        vertexBuffer = device.makeBuffer(bytes: vertexPositionColors, length: vertexDataSize, options: [])
        
        print("Need to test this")
        
        //Buffer Indices
        indexBuffer = REMesh.bufferIndices32(indices: indices, device: device)
        indexCount = indices.count
        primitiveCount = indexCount/3
        
        super.init()
    }
    
    init(vertexPositionTextures: [VertexPosTex], indices: [UInt32], device: MTLDevice) {
        
        let vertexDataSize = vertexPositionTextures.count * MemoryLayout.size(ofValue: vertexPositionTextures[0])
        vertexBuffer = device.makeBuffer(bytes: vertexPositionTextures, length: vertexDataSize, options: [])
        
        //Buffer Indices
        indexBuffer = REMesh.bufferIndices32(indices: indices, device: device)
        indexCount = indices.count
        primitiveCount = indexCount/3
        
        super.init()
    }
    
    init(vertexPositionNormalTextures: [VertexPosNorTex], indices: [UInt32], device: MTLDevice) {
        
        let vertexDataSize = vertexPositionNormalTextures.count * MemoryLayout.size(ofValue: vertexPositionNormalTextures[0])
        vertexBuffer = device.makeBuffer(bytes: vertexPositionNormalTextures, length: vertexDataSize, options: [])
        
        //Buffer Indices
        indexBuffer = REMesh.bufferIndices32(indices: indices, device: device)
        indexCount = indices.count
        primitiveCount = indexCount/3
        
        super.init()
    }
    
    init(vertexPositionNormalTextureBones: [VertexPosNorTexBone], indices: [UInt32], device: MTLDevice) {
        
        let vertexDataSize = vertexPositionNormalTextureBones.count * MemoryLayout.size(ofValue: vertexPositionNormalTextureBones[0])
        vertexBuffer = device.makeBuffer(bytes: vertexPositionNormalTextureBones, length: vertexDataSize, options: [])
        
        //Buffer Indices
        indexBuffer = REMesh.bufferIndices32(indices: indices, device: device)
        indexCount = indices.count
        primitiveCount = indexCount/3
        
        super.init()
    }
    
    deinit{
        //self.deleteMesh()
    }
    
    private static func bufferIndices32(indices: [UInt32], device: MTLDevice) -> MTLBuffer
    {
        var indexData = Array<UInt32>() //TODO: Get rid of this
        for index in indices {
            indexData.append(index)
        }
        
        let indexDataSize = indexData.count * MemoryLayout.size(ofValue: indexData[0])
        return device.makeBuffer(bytes: indexData, length: indexDataSize, options: [])!
    }
    
    func deleteMesh()
    {
        if !released
        {
            vertexBuffer.setPurgeableState(MTLPurgeableState.empty)
            indexBuffer.setPurgeableState(MTLPurgeableState.empty)
        }
        
        vertexBuffer = nil
        indexBuffer = nil
        
        released = true
    }
    
    func drawMesh(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
    }
    
    func drawPrebufferedMesh(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: indexCount, indexType: .uint32, indexBuffer: indexBuffer, indexBufferOffset: 0, instanceCount: primitiveCount)
    }
}
