//
//  Renderer.swift
//  GraphicsEngineMetal
//
//  Created by Alexander Farrell on 6/5/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

import UIKit
import Metal
import MetalKit
import QuartzCore

class Renderer: NSObject {
    var device: MTLDevice!
    var library: MTLLibrary!
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    var renderPassDescriptor: MTLRenderPassDescriptor!
    var currentRenderPiplineIdentifier: String = "Default"
    
    private var renderPipelineStates = Dictionary<String, MTLRenderPipelineState>()
    
    private var depthTexture: MTLTexture!
    private var depthStencilState: MTLDepthStencilState!
    
    var texture: MTLTexture!
    var sampler: MTLSamplerState!
    var metalLayer: CAMetalLayer!
    
    var drawable: CAMetalDrawable!
    var commandBuffer: MTLCommandBuffer!
    var renderCommandEncoder: MTLRenderCommandEncoder!
    
    init(view: UIView) {
        super.init()
        
        device = MTLCreateSystemDefaultDevice()
        library = device.makeDefaultLibrary()
        commandQueue = device.makeCommandQueue()
        
        //Initialize Metal Layer
        let scaleFactor = UIScreen.main.nativeScale
        
        var drawableSize = view.frame
        drawableSize.size.width = view.frame.width * CGFloat(scaleFactor)
        drawableSize.size.height = view.frame.height * CGFloat(scaleFactor)
        metalLayer = CAMetalLayer()
        metalLayer.device = device;
        metalLayer.pixelFormat = .bgra8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.frame
        metalLayer.drawableSize = drawableSize.size
        //view.layer.addSublayer(MetalLayer)
        view.layer.insertSublayer(metalLayer, at: 0)
        
        let vertexProgram = library.makeFunction(name: "basic_vertexUvpt")
        let fragmentProgram = library.makeFunction(name: "basic_fragmentUvpt")
        
        let renderPipelineDesc = MTLRenderPipelineDescriptor()
        renderPipelineDesc.vertexFunction = vertexProgram
        renderPipelineDesc.fragmentFunction = fragmentProgram
        renderPipelineDesc.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDesc.depthAttachmentPixelFormat = .depth32Float
        let renderPipelineStateLoad = try! device.makeRenderPipelineState(descriptor: renderPipelineDesc)
        renderPipelineStates["Default"] = renderPipelineStateLoad
        
        renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].storeAction = .store
        
        let samplerDesc = MTLSamplerDescriptor()
        samplerDesc.minFilter = .linear
        samplerDesc.magFilter = .linear
        samplerDesc.mipFilter = .linear
        samplerDesc.tAddressMode = .repeat
        samplerDesc.sAddressMode = .repeat
        sampler = device.makeSamplerState(descriptor: samplerDesc)
        
        let depthTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: .depth32Float, width: Int(drawableSize.size.width), height: Int(drawableSize.size.height), mipmapped: false)
        depthTextureDescriptor.sampleCount = 1
        depthTextureDescriptor.usage = MTLTextureUsage.unknown
        depthTextureDescriptor.storageMode = MTLStorageMode.private
        depthTexture = device.makeTexture(descriptor: depthTextureDescriptor)
        
        let depthAttachment = renderPassDescriptor.depthAttachment
        depthAttachment?.texture = depthTexture
        depthAttachment?.loadAction = MTLLoadAction.clear
        depthAttachment?.storeAction = MTLStoreAction.store
        depthAttachment?.clearDepth = 1.0
        
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.depthCompareFunction = MTLCompareFunction.less
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
    func changeClearColor(clearColorRed: Double, clearColorGreen: Double, clearColorBlue: Double)
    {
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(clearColorRed, clearColorGreen, clearColorBlue, 1.0)
    }
    
    //MARK: - Begin and End Updating the Screen
    
    func beginDraw() {
        drawable = metalLayer.nextDrawable()
        commandBuffer = commandQueue.makeCommandBuffer()
        
        if drawable != nil
        {
            renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        }
        else
        {
            print("Could not get new drawable.")
        }
    }
    
    func endDraw() {
        commandBuffer.present(drawable!)
        commandBuffer.commit()
    }
    
    //MARK: - Begin and End a Single Draw Call. Multiple items can be completed in a single draw call.
    
    func beginRenderPass()
    {
        renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderPipelineState = renderPipelineStates["Default"]
        renderCommandEncoder.setRenderPipelineState(renderPipelineState)
        renderCommandEncoder.setDepthStencilState(depthStencilState)
        //renderCommandEncoder.setFragmentTexture(texture, at: 0)
        renderCommandEncoder.setFragmentSamplerState(sampler, index: 0)
    }
    
    func endRenderPass() {
        renderCommandEncoder.endEncoding()
    }
    
    //MARK: - Set the Material
    func newMaterial(vertexProgram: String, fragmentProgram: String, identifier: String)
    {
        let vertexProgramLoad = library.makeFunction(name: vertexProgram)
        let fragmentProgramLoad = library.makeFunction(name: fragmentProgram)
        
        let renderPipelineDesc = MTLRenderPipelineDescriptor()
        renderPipelineDesc.vertexFunction = vertexProgramLoad
        renderPipelineDesc.fragmentFunction = fragmentProgramLoad
        renderPipelineDesc.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDesc.depthAttachmentPixelFormat = .depth32Float
        let renderPipelineStateLoad = try! device.makeRenderPipelineState(descriptor: renderPipelineDesc)
        
        renderPipelineStates[identifier] = renderPipelineStateLoad
    }
    
    func setRenderPipelineState(identifier: String)
    {
        renderCommandEncoder.setRenderPipelineState(renderPipelineStates[identifier]!)
        currentRenderPiplineIdentifier = identifier
    }
    
    //MARK: - Draw a mesh
    
    func drawMesh(mesh: REMesh) {
        renderCommandEncoder.setVertexBuffer(mesh.vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawIndexedPrimitives(type: .triangle, indexCount: mesh.indexCount, indexType: .uint32, indexBuffer: mesh.indexBuffer, indexBufferOffset: 0)
    }
    
    //MARK: - Set Texture
    
    func setTexture(texture: RETexture)
    {
        renderCommandEncoder.setFragmentTexture((texture.textureBuffer!), index: 0)
    }
    
    func setTexture(texture: RETexture, at: Int)
    {
        renderCommandEncoder.setFragmentTexture((texture.textureBuffer!), index: at)
    }
    
    //MARK: - Set Buffer
    
    func setVertexBuffer(buffer: MTLBuffer, index: Int) {
        renderCommandEncoder.setVertexBuffer(buffer, offset: 0, index: index)
    }
    
    func setFragmentBuffer(buffer: MTLBuffer, index: Int)
    {
        renderCommandEncoder.setFragmentBuffer(buffer, offset: 0, index: index)
    }
}

