//
//  RETexture.swift
//  GraphicsEngineMetal
//
//  Created by Alexander Farrell on 6/5/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit
import Metal
import MetalKit

fileprivate struct PixelDataRGBA8
{
    var a: UInt8
    var r: UInt8
    var g: UInt8
    var b: UInt8
}

class RETexture: NSObject {
    var textureBuffer: MTLTexture!
    var released: Bool = false
    
    init(textureDescriptor: MTLTextureDescriptor, device: MTLDevice) {
        textureBuffer = device.makeTexture(descriptor: textureDescriptor)
        super.init()
    }
    
    init(textureName: String, device: MTLDevice) {
        let textureLoader = MTKTextureLoader.init(device: device)
        super.init()
        textureBuffer = try! textureLoader.newTexture(name: textureName, scaleFactor: 1.0, bundle: nil, options: [MTKTextureLoader.Option.SRGB : (false as NSNumber)])
        print("Added MTLTexture from file '" + textureName + "'")
        //TODO: add MTKTextureLoaderOptionTextureUsage to ShaderRead and StorageMode to Private
    }
    
    init(uiImage: UIImage, device: MTLDevice)
    {
        let textureLoader = MTKTextureLoader.init(device: device)
        
        super.init()
        
        textureBuffer = try! textureLoader.newTexture(cgImage: uiImage.cgImage!, options: [MTKTextureLoader.Option.SRGB : (false as NSNumber)])
        print("Added MTLTexture from UIImage")
    }
    
    init(cgImage: CGImage, device: MTLDevice)
    {
        let textureLoader = MTKTextureLoader.init(device: device)
        
        super.init()
        
        textureBuffer = try! textureLoader.newTexture(cgImage: cgImage, options: [MTKTextureLoader.Option.SRGB : (false as NSNumber)])
        
        print("Added MTLTexture from CGImage")
    }
    
    init(cgImage: CGImage, renderer: Renderer)
    {
        let textureLoader = MTKTextureLoader.init(device: renderer.device)
        
        super.init()
        
        textureBuffer = try! textureLoader.newTexture(cgImage: cgImage, options: [MTKTextureLoader.Option.SRGB : (false as NSNumber), MTKTextureLoader.Option.allocateMipmaps : (true as NSNumber), MTKTextureLoader.Option.generateMipmaps : (true as NSNumber)])
        
        print("Added MTLTexture from CGImage")
        
    }
    
    init(clayImage: ClayImage, renderer: Renderer, mipmapped: Bool)
    {
        var mipmappingOn: Bool
        
        if (clayImage.Width < 2) || (clayImage.Height < 2)
        {
            mipmappingOn = false
        }
        else
        {
            mipmappingOn = mipmapped
        }
        
        assert(clayImage.Pixels.count == clayImage.Width * clayImage.Height)
        
        //Get this to be normal var data = Pixels
        var pixelData = [PixelDataRGBA8]()
        
        var iPixel = 0
        
        while iPixel < clayImage.Pixels.count
        {
            let pixel = clayImage.Pixels[iPixel]
            pixelData.append(PixelDataRGBA8.init(a: clayImage.floatToUInt8Pixel(floatValue: pixel.b/*blue*/), r: clayImage.floatToUInt8Pixel(floatValue: pixel.g/*green*/), g: clayImage.floatToUInt8Pixel(floatValue: pixel.r)/*red*/, b: clayImage.floatToUInt8Pixel(floatValue: pixel.a/*alpha I think*/)))
            
            iPixel += 1
        }
        
        let descriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .bgra8Unorm, width: clayImage.Width, height: clayImage.Height, mipmapped: mipmappingOn)
        
        textureBuffer = renderer.device.makeTexture(descriptor: descriptor)
        
        let region = MTLRegionMake2D(0, 0, clayImage.Width, clayImage.Height)
        textureBuffer.replace(region: region, mipmapLevel: 0, withBytes: pixelData, bytesPerRow: 4 * clayImage.Width)
        
        if mipmappingOn
        {
            let commandBuffer = renderer.commandQueue.makeCommandBuffer()
            let commandEncoder: MTLBlitCommandEncoder = (commandBuffer?.makeBlitCommandEncoder())!
            commandEncoder.generateMipmaps(for: textureBuffer)
            commandEncoder.endEncoding()
            commandBuffer?.commit()
        }
        
        print("Added MTLTexture from Clay Texture")
    }
    
    /*init(data: NSData, device: MTLDevice)
    {
        let textureLoader = MTKTextureLoader.init(device: device)
        
        super.init()
        
        textureBuffer = try! textureLoader.newTexture(data: data as Data, options: [MTKTextureLoader.Option.SRGB : (false as NSNumber)])
        print("Added MTLTexture from UIImage")
    }*/
    
    func Delete()
    {
        if !released
        {
            textureBuffer.setPurgeableState(MTLPurgeableState.empty)
        }
        
        textureBuffer = nil
        released = true
    }
    
    deinit{
        //self.Delete()
    }
}
