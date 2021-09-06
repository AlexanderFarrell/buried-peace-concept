//
//  VertexTypes.swift
//  GraphicsEngineMetal
//
//  Created by Alexander Farrell on 6/5/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum VertexDeclaration {
    case VDVertexPosCol
    case VDVertexPosTex
    case VDVertexPosNorTex
    case VDVertexPosNorTexBone
}

struct VertexPosCol {
    var x, y, z: Float
    var red, green, blue, alpha: Float
    
    func floatBuffer()-> [Float]
    {
        return [x, y, z, red, green, blue, alpha]
    }
    
    func vertexDeclaration() -> VertexDeclaration {
        return VertexDeclaration.VDVertexPosCol
    }
}

struct VertexPosTex {
    var x, y, z: Float
    var textureX, textureY: Float
    
    func floatBuffer() -> [Float] {
        return [x, y, z, textureX, textureY]
    }
    
    func vertexDeclaration() -> VertexDeclaration {
        return VertexDeclaration.VDVertexPosTex
    }
}

struct VertexPosNorTex {
    var x, y, z: Float
    var normX, normY, normZ: Float
    var textureX, textureY: Float
    
    func floatBuffer() -> [Float] {
        return [x, y, z, normX, normY, normZ, textureX, textureY]
    }
    
    func vertexDeclaration() -> VertexDeclaration {
        return VertexDeclaration.VDVertexPosNorTex
    }
}

struct VertexPosNorTexBone {
    var x, y, z: Float
    var normX, normY, normZ: Float
    var textureX, textureY: Float
    var index0, index1, index2, index3: Int32
    var weight0, weight1, weight2, weight3: Float
    
    func floatBuffer() -> [Float]
    {
        return [x, y, z, normX, normY, normZ, textureX, textureY, Float.init(bitPattern: UInt32(index0)), Float.init(bitPattern: UInt32(index1)), Float.init(bitPattern: UInt32(index2)), Float.init(bitPattern: UInt32(index3)), weight0, weight1, weight2, weight3]
    }
    
    func vertexDeclaration() -> VertexDeclaration {
        return VertexDeclaration.VDVertexPosNorTexBone
    }
}
