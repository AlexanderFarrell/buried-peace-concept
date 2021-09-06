//
//  Room.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/28/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Room: GameplayObject {
    var floors = [Floor]()
    var walls = [Wall]()
    var connectedRooms = Set<Room>()
    //Entity demands?
    
    func subdivideFloorsRoughAndConnect(minSize: Float, maxSize: Float, random: ClayRandom)
    {
        var newFloors = [Floor]()
        
        for floor in floors
        {
            let midpoint = floor.getMidpointOptimized()
            
            let topLeft = TDVector2Lerp(midpoint, TDVector2Make(floor.Left.pointOne.x, floor.Left.pointOne.y), random.nextFloatInRange(minValue: minSize, maxValue: maxSize))
            let topRight = TDVector2Lerp(midpoint, TDVector2Make(floor.Right.pointOne.x, floor.Right.pointOne.y), random.nextFloatInRange(minValue: minSize, maxValue: maxSize))
            let bottomLeft = TDVector2Lerp(midpoint, TDVector2Make(floor.Left.pointTwo.x, floor.Left.pointTwo.y), random.nextFloatInRange(minValue: minSize, maxValue: maxSize))
            let bottomRight = TDVector2Lerp(midpoint, TDVector2Make(floor.Right.pointTwo.x, floor.Right.pointTwo.y), random.nextFloatInRange(minValue: minSize, maxValue: maxSize))
            
            let newFloor = Floor.init(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
            
            if floor.leftNeighbor != nil
            {
                floor.leftNeighbor?.rightNeighbor = newFloor
            }
            
            if floor.rightNeighbor != nil
            {
                floor.rightNeighbor?.leftNeighbor = newFloor
            }
            
            if floor.topNeighbor != nil
            {
                floor.topNeighbor?.bottomNeighbor = newFloor
            }
            
            if floor.bottomNeighbor != nil
            {
                floor.bottomNeighbor?.topNeighbor = newFloor
            }
            
            newFloor.leftNeighbor = floor.leftNeighbor
            newFloor.rightNeighbor = floor.rightNeighbor
            newFloor.topNeighbor = floor.topNeighbor
            newFloor.bottomNeighbor = floor.bottomNeighbor
            
            newFloor.generateLeftWall = floor.generateLeftWall
            newFloor.generateRightWall = floor.generateRightWall
            newFloor.generateTopWall = floor.generateTopWall
            newFloor.generateBottomWall = floor.generateBottomWall
            
            newFloors.append(newFloor)
        }
        
        floors = newFloors
        
        var connectingFloorsToAdd = [Floor]()
        
        for floor in newFloors
        {
            if floor.leftNeighbor != nil
            {
                let otherFloor = floor.leftNeighbor!
                
                let topLeft = TDVector2Make(otherFloor.Right.pointOne.x, otherFloor.Right.pointOne.y)
                let topRight = TDVector2Make(floor.Left.pointOne.x, floor.Left.pointOne.y)
                let bottomLeft = TDVector2Make(otherFloor.Right.pointTwo.x, otherFloor.Right.pointTwo.y)
                let bottomRight = TDVector2Make(floor.Left.pointTwo.x, floor.Left.pointTwo.y)
                
                let connectingFloor = Floor.init(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
                connectingFloor.rightNeighbor = floor
                connectingFloor.leftNeighbor = otherFloor
                
                connectingFloorsToAdd.append(connectingFloor)
            }
            
            if floor.topNeighbor != nil
            {
                let otherFloor = floor.topNeighbor!
                
                let topLeft = otherFloor.Left.pointTwo.getVector()
                let topRight = otherFloor.Right.pointTwo.getVector()
                let bottomLeft = floor.Left.pointOne.getVector()
                let bottomRight = floor.Right.pointOne.getVector()
                
                let connectingFloor = Floor.init(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
                connectingFloor.bottomNeighbor = floor
                connectingFloor.topNeighbor = otherFloor
                
                connectingFloorsToAdd.append(connectingFloor)
            }
        }
        
        floors.append(contentsOf: connectingFloorsToAdd)
        
        //We only worry about the top and left connections. That way, were not doing double the work.
    }
    
    func populateWithWalls(heightOfWalls: Float)
    {
        for floor in floors
        {
            walls.append(contentsOf: floor.getWalls(height: heightOfWalls))
        }
    }
}
