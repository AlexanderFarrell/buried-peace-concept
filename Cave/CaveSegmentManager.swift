//
//  CaveSegmentManager.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/11/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class CaveSegmentManager: SegmentManager {
    var gameplayDelegate: GameplayDelegate!
    var worldScene: WorldScene!
    
    override init() {
        super.init()
        
        bufferDistance = Constants.CaveBufferRadius
        debufferDistance = Constants.CaveDebufferRadius
        segmentSize = Constants.CaveSegmentSize
    }
    
    override func bufferSegment(segment: Segment) {
        super.bufferSegment(segment: segment)
    }
    
    override func createNewSegment() -> Segment {
        let segment = CaveSegment()
        segment.gameplayDelegate = self.gameplayDelegate
        return segment
    }
    
    //Map
    func getSquare(x: Int, y: Int) -> CaveSquare?
    {
        //Find the segment it is in
        let xSegment = Int(floor(Double(x)/segmentSize))
        let ySegment = Int(floor(Double(y)/segmentSize))
        
        if let caveSegment = getSegmentAt(x: xSegment, y: ySegment)
        {
            let segmentSizeInt = Int(segmentSize)
            let retVal = (caveSegment as! CaveSegment).squares[x - (xSegment * segmentSizeInt)][y - (ySegment * segmentSizeInt)]
            
            if retVal.exists
            {
                return retVal
            }
            else
            {
                return nil
            }
        }
        else
        {
            return nil
        }
    }
}
