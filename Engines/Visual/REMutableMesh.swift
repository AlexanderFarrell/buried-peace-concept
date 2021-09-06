//
//  REMutableMesh.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 2/3/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class REMutableMesh: NSObject {
    var cpuCopyOneTex: [VertexPosTex] = [VertexPosTex]()
    var cpuCopyOneIndices: [UInt32] = [UInt32]()
    
    var cpuCopyTwoTex: [VertexPosTex] = [VertexPosTex]()
    var cpuCopyTwoIndices: [UInt32] = [UInt32]()
    
    var vertexBufferOne: MTLBuffer!
    var indexBufferOne:  MTLBuffer!
    var vertexBufferTwo: MTLBuffer!
    var indexBufferTwo:  MTLBuffer!
    
    var activeRenderBuffer: Int = 0
    
    var released: Bool = false;
    
    var indexCountOne: Int = 0
    var primitiveCountOne: Int = 0
    var indexCountTwo: Int = 0
    var primitiveCountTwo: Int = 0
    
    override init() {
        super.init()
    }
    
    func getVertices() -> [VertexPosTex]
    {
        if activeRenderBuffer == 1
        {
            return cpuCopyTwoTex
        }
        else
        {
            return cpuCopyOneTex
        }
    }
    
    func getIndices() -> [UInt32]
    {
        
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
    
    private static func bufferIndices32(indices: [UInt32], device: MTLDevice) -> MTLBuffer
    {
        let indexDataSize = indices.count * MemoryLayout.size(ofValue: indices[0])
        return device.makeBuffer(bytes: indices, length: indexDataSize, options: [])!
    }
    
    func deleteMesh()
    {
        
    }
    
    func drawMesh(renderCommandEncoder: MTLRenderCommandEncoder)
    {
        
    }
}
