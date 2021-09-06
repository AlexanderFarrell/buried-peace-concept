//
//  Cave.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Cave: MicroWorldComponent, SegmentManagerDelegate {
    
    //MARK: - Segment Management
    var segmentManager: CaveSegmentManager?
    var generated = false
    
    //MARK: - Rendering
    var texturePalette: CaveTexturePalette = CaveTexturePalette()
    var transform: RETransformMVP!
    var ambientColor = [Float(1.0), Float(1.0), Float(1.0), Float(1.0)]
    var ambientColorBuffer: REBuffer!
    var directionalLightPosition = TDVector3Normalize(TDVector3Make(40.0, 5.0, 20.0))
    var directionalLightPositionBuffer: REBuffer!
    
    override func load()
    {
        let worldScene = getWorldScene()
        var savedGame = getSavedGame()
        
        texturePalette.load()
    }
    
    //MARK: - Setup and Breakdown
    override func setup() {
        let worldScene = getWorldScene()
        
        setupGPUResources()
        
        createSegments() //Has to be called
        
        generated = true
    }
    
    override func breakdown() {
        for segment in segmentManager!.bufferedSegments
        {
            (segment as! CaveSegment).breakdown()
        }
    }
    
    //MARK: - Cycles
    override func update() {
        
        if segmentManager != nil
        {
            segmentManager!.update(xCenter: Double(getEntityEngine().player.x), yCenter: Double(getEntityEngine().player.z))
        }
    }
    
    override func draw()
    {
        transform.UpdateValue(worldMatrix: TDMatrix4Identity, camera: self.gameplayDelegate.getActiveCamera())
        
        //Draw the segments
        
        for segment in segmentManager!.bufferedSegments
        {
            (segment as! CaveSegment).draw(transform: transform)
        }
    }
    
    //MARK: - Set Up Methods
    fileprivate func setupGPUResources() {
        let directionalLightPositionData = [directionalLightPosition.v.0, directionalLightPosition.v.1, directionalLightPosition.v.2, 1.0]
        
        ambientColorBuffer = REBuffer.init(device: self.getRenderer().device, bytes: ambientColor, length: MSCMathHelper.dataSizeOfArray(data: ambientColor))
        directionalLightPositionBuffer = REBuffer.init(device: self.getRenderer().device, bytes: directionalLightPositionData, length: MSCMathHelper.dataSizeOfArray(data: directionalLightPositionData))
        
        transform = RETransformMVP.init(device: getRenderer().device)
        
        texturePalette.gameplayDelegate = gameplayDelegate
        texturePalette.setup()
    }
    
    private func createSegments()
    {
        //Generate the graphics.
        
        if segmentManager != nil
        {
            for bufferedSegment in segmentManager!.bufferedSegments
            {
                let caveSegment = (bufferedSegment as! CaveSegment)
                caveSegment.breakdown()
            }
        }
        
        segmentManager = CaveSegmentManager()
        segmentManager!.gameplayDelegate = gameplayDelegate
        segmentManager!.delegate = self
    }
    
    func getSquare(x: Int, y: Int) -> CaveSquare?
    {
        return segmentManager!.getSquare(x: x, y: y)
    }
    
    func bufferSegment(segment: Segment, manager: SegmentManager) {
        
    }
    
    func debufferSegment(segment: Segment, manager: SegmentManager) {
        
    }
}
