//
//  REBuffer.swift
//  GraphicsEngineMetal
//
//  Created by Alexander Farrell on 6/5/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit
import Metal

class REBuffer: NSObject {
    private var bufferOne: MTLBuffer!
    private var bufferTwo: MTLBuffer!
    private var isPrimaryBufferActive: Bool!
    
    var released: Bool = false
    
    init(device: MTLDevice, bytes: UnsafeRawPointer, length: Int) {
        bufferOne = device.makeBuffer(bytes: bytes, length: length, options: [])
        bufferTwo = device.makeBuffer(length: length, options: [])
        
        isPrimaryBufferActive = true
        
        //print("Buffer created with length: " + String(length))
        
        super.init()
    }
    
    func updateValue(bytes: UnsafeRawPointer, length: Int) {
        if isPrimaryBufferActive
        {
            //bufferTwo.contents().copyBytes(from: bytes, count: length)
            
            let bufferPointer = bufferTwo.contents()
            memcpy(bufferPointer, bytes, length)
            
            isPrimaryBufferActive = false
        }
        else
        {
            //bufferOne.contents().copyBytes(from: bytes, count: length)
            
            let bufferPointer = bufferOne.contents()
            memcpy(bufferPointer, bytes, length)
            isPrimaryBufferActive = true
        }
    }
    
    func deleteBuffer()
    {
        if !released
        {
            bufferOne.setPurgeableState(MTLPurgeableState.empty)
            bufferTwo.setPurgeableState(MTLPurgeableState.empty)
        }
        
        bufferOne = nil
        bufferTwo = nil
        
        released = true
        
        //Test!!!!!!!
    }
    
    /*
     
     let bufferPointer = uniformBuffer.contents()
     memcpy(bufferPointer, nodeModelMatrix.raw(), MemoryLayout<Float>.size * Matrix4.numberOfElements())
     memcpy(bufferPointer + MemoryLayout<Float>.size * Matrix4.numberOfElements(), projectionMatrix.raw(),
     */
    
    func getBufferActive() -> MTLBuffer
    {
        if isPrimaryBufferActive
        {
            return bufferOne
        }
        else
        {
            return bufferTwo
        }
    }
    
    deinit{
        //self.deleteBuffer()
    }
}
