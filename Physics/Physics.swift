//
//  Physics.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/30/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Physics: MicroWorldComponent {
    var boundingObjects: Set<BoundingSphere> = Set<BoundingSphere>()
    var gravity: Float = 0.0
    
    override func setup() {
        
    }
    
    override func load()
    {
        let legend = getLegend()
        var savedGame = getSavedGame()
    }
    
    func isPositionValid(position: TDVector3, radius: Float) -> Bool
    {
        _ = MSCPoint2.init(x: Double(position.v.0), y: Double(position.v.2))
        
        let isInRoom = true //Check from grid
        var isCollisionFree = true
        
        let inputBounds = BoundingSphere()
        inputBounds.setCenterWithVector(vector: position)
        inputBounds.radius = radius
        
        for boundingObject in boundingObjects {
            if boundingObject.isCollidingWithBounds(bounds: inputBounds)
            {
                isCollisionFree = false
            }
        }
        
        return ((isInRoom) && (isCollisionFree))
    }
    
    func isLineValid(start: TDVector3, end: TDVector3, checkPer: Float) -> Bool
    {
        //Constants
        let distance = TDVector3Distance(start, end)
        let checkpointCount = (distance > checkPer) ? Int(floor(distance/checkPer)) : 0
        let direction = TDVector3Subtract(end, start)
        let singleStep = TDVector3MultiplyScalar(TDVector3Normalize(direction), checkPer)
        
        //Check Start
        if !isPositionValid(position: start, radius: 0.0)
        {
            return false
        }
        
        //Check Middle
        
        var iCheck = 0
        var currentCheckPos = start
        
        while iCheck < checkpointCount
        {
            currentCheckPos = TDVector3Add(currentCheckPos, singleStep)
            
            if !isPositionValid(position: currentCheckPos, radius: 0.0)
            {
                return false
            }
            
            iCheck += 1
        }
        
        
        //Check End
        if !isPositionValid(position: start, radius: 0.0)
        {
            return false
        }
        
        return true
    }
    
    func validatePosition(position: TDVector3, radius: Float) -> TDVector3
    {
        var inputBounds = BoundingSphere()
        inputBounds.setCenterWithVector(vector: position)
        inputBounds.radius = radius
        
        for boundingObject in boundingObjects {
            inputBounds = boundingObject.validateBoundsWithBounds(bounds: inputBounds)
        }
        
        let location = MSCPoint2.init(x: Double(position.v.0), y: Double(position.v.2))
        
        //Check now if its inside
        
        return inputBounds.getVectorCenter()
    }
}
