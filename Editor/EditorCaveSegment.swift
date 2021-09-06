//
//  EditorCaveSegment.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 2/3/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class EditorCaveSegment: Segment {
    
    //Admin
    var hasGraphicsData: Bool = false
    var gameplayDelegate: GameplayDelegate!
    
    //Graphics
    var meshes = [REMesh]()
    var meshesTwo = [REMesh]()
    var textureIndices = [Int]() //TODO: Make texture indices into material indices. This will allow things like water to be rendered.
    var textureIndicesTwo = [Int]()
    
    var renderReadyMeshes = 2
    
    //Position on Map
    var xStartMap: Int = 0
    var yStartMap: Int = 0
    var xEndMap: Int = 1
    var yEndMap: Int = 1
    
    var buffering = false
    var readyToRender = false
    
    override func buffer() {
        if !buffering
        {
            super.buffer()
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.buffering = true
                
                self.xStartMap = self.xInSegments * Int(Constants.CaveSegmentSize/Constants.squareSize)
                self.xEndMap = (self.xInSegments + 1) * Int(Constants.CaveSegmentSize/Constants.squareSize)
                self.yStartMap = self.yInSegments * Int(Constants.CaveSegmentSize/Constants.squareSize)
                self.yEndMap = (self.yInSegments + 1) * Int(Constants.CaveSegmentSize/Constants.squareSize)
                
                self.generateMeshes(cave: self.gameplayDelegate.getCave())
                
                if self.hasGraphicsData
                {
                    self.readyToRender = true
                }
                
                DispatchQueue.main.async {
                    
                }
            }
        }
        //Multithreaded version test later
        /*if !buffering
         {
         buffering = true
         
         DispatchQueue.global(qos: .userInitiated).async {
         self.generateMeshes(cave: self.gameplayDelegate.getCave())
         
         if self.hasGraphicsData
         {
         self.readyToRender = true
         }
         
         DispatchQueue.main.async {
         
         }
         }
         
         buffering = false
         }*/
    }
    
    func generateMeshes(cave: Cave)
    {
        var meshesToTexture = Dictionary<Int, ClayMesh>()
        
        if renderReadyMeshes == 1
        {
            //Release
            if meshesTwo.count > 0
            {
                var iMesh = 0
                
                while iMesh < meshesTwo.count
                {
                    meshesTwo[iMesh].deleteMesh()
                    
                    iMesh += 1
                }
                
                meshesTwo.removeAll()
                textureIndicesTwo.removeAll()
            }
            
            meshesTwo = [REMesh]()
            textureIndicesTwo = [Int]()
        }
        else
        {
            //Release
            if meshes.count > 0
            {
                var iMesh = 0
                
                while iMesh < meshes.count
                {
                    meshes[iMesh].deleteMesh()
                    
                    iMesh += 1
                }
                
                meshes.removeAll()
                textureIndices.removeAll()
            }
            
            meshes = [REMesh]()
            textureIndices = [Int]()
        }
        
        //Have each square add its mesh
        var ix = 0//xStartMap
        var iy = 0//yStartMap
        
        
        while ix < xEndMap
        {
            iy = yStartMap
            
            while iy < yEndMap
            {
                if let square = cave.getSquare(x: ix, y: iy)
                {
                    meshesToTexture = square.addToMeshes(meshesToTexture: meshesToTexture)
                }
                
                iy += 1
            }
            
            ix += 1
        }
        
        if meshesToTexture.count > 0
        {
            for (textureIndex, clayMesh) in meshesToTexture
            {
                let mesh = clayMesh.getMeshVertexPosTex(renderer: gameplayDelegate.getRenderer())
                
                if renderReadyMeshes == 1
                {
                    meshesTwo.append(mesh)
                    textureIndicesTwo.append(textureIndex)
                }
                else
                {
                    meshes.append(mesh)
                    textureIndices.append(textureIndex)
                }
            }
            
            hasGraphicsData = true
        }
        else
        {
            hasGraphicsData = false
        }
        
        if renderReadyMeshes == 1
        {
            renderReadyMeshes = 2
        }
        else
        {
            renderReadyMeshes = 1
        }
    }
    
    override func debuffer() {
        breakdown()
        
        super.debuffer()
    }
    
    func breakdown()
    {
        readyToRender = false
        
        var iDrawCall = 0
        
        while iDrawCall < meshes.count
        {
            meshes[iDrawCall].deleteMesh()
            
            iDrawCall += 1
        }
        
        meshes.removeAll()
        textureIndices.removeAll()
        
        gameplayDelegate = nil
    }
    
    func draw(transform: RETransformMVP)
    {
        if readyToRender
        {
            let renderer = gameplayDelegate.getRenderer()
            let caveTexture = gameplayDelegate.getCave().texturePalette.textures[0]
            
            var iDrawCall = 0
            
            if renderReadyMeshes == 1
            {
                while iDrawCall < meshes.count
                {
                    renderer.setTexture(texture: caveTexture/*[textureIndices[iDrawCall]]*/)
                    renderer.setVertexBuffer(buffer: transform.BufferedTransform!.getBufferActive(), index: 1)
                    renderer.drawMesh(mesh: meshes[iDrawCall])
                    
                    iDrawCall += 1
                }
            }
            else
            {
                while iDrawCall < meshesTwo.count
                {
                    renderer.setTexture(texture: caveTexture/*[textureIndices[iDrawCall]]*/)
                    renderer.setVertexBuffer(buffer: transform.BufferedTransform!.getBufferActive(), index: 1)
                    renderer.drawMesh(mesh: meshesTwo[iDrawCall])
                    
                    iDrawCall += 1
                }
            }
        }
    }
}
