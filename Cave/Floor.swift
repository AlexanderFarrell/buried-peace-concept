//
//  Floor.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/28/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Floor: ProjectionArea2D {
    var leftNeighbor: Floor?
    var rightNeighbor: Floor?
    var topNeighbor: Floor?
    var bottomNeighbor: Floor?
    
    var generateLeftWall: Bool = true
    var generateRightWall: Bool = true
    var generateTopWall: Bool = true
    var generateBottomWall: Bool = true
    
    var quadrilateralBounds: MSCQuadrilateral
    
    override init(topLeft: TDVector2, topRight: TDVector2, bottomLeft: TDVector2, bottomRight: TDVector2) {
        quadrilateralBounds = MSCQuadrilateral.init(topLeft: MSCPoint2.getMSCPointFromVector(vector: topLeft), topRight: MSCPoint2.getMSCPointFromVector(vector: topRight), bottomLeft: MSCPoint2.getMSCPointFromVector(vector: bottomLeft), bottomRight: MSCPoint2.getMSCPointFromVector(vector: bottomRight))
        
        super.init(topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight)
    }
    
    func getMidpointOptimized() -> TDVector2
    {
        let xMid = (Left.pointOne.x + Left.pointTwo.x + Right.pointOne.x + Right.pointTwo.x)/4.0
        let yMid = (Left.pointOne.y + Left.pointTwo.y + Right.pointOne.y + Right.pointTwo.y)/4.0
        
        let midpoint = TDVector2Make(xMid, yMid)
        
        return midpoint
    }
    
    func getWalls(height: Float) -> [Wall]
    {
        var retValWalls = [Wall]()
        
        /* if !generateLeftWall
        {
            assert(leftNeighbor == nil)
        }
        
        if !generateRightWall
        {
            assert(rightNeighbor == nil)
        }
        
        if !generateTopWall
        {
            assert(topNeighbor == nil)
        }
        
        if !generateBottomWall
        {
            assert(bottomNeighbor == nil)
        }*/
        
        
        if (leftNeighbor == nil) && (generateLeftWall)
        {
            //Add to control points to make depth? But we need them.
            
            retValWalls.append(Wall.init(inStart: Left.pointOne.getVector(), inEnd: Left.pointTwo.getVector(), outStart: Left.pointOne.getVector(), outEnd: Left.pointTwo.getVector(), inHeight: Double(height)))
        }
        
        if (rightNeighbor == nil) && (generateRightWall)
        {
            //Add to control points to make depth? But we need them.
            
            retValWalls.append(Wall.init(inStart: Right.pointOne.getVector(), inEnd: Right.pointTwo.getVector(), outStart: Right.pointOne.getVector(), outEnd: Right.pointTwo.getVector(), inHeight: Double(height)))
        }
        
        if (topNeighbor == nil) && (generateTopWall)
        {
            //Add to control points to make depth? But we need them.
            
            retValWalls.append(Wall.init(inStart: Top.pointOne.getVector(), inEnd: Top.pointTwo.getVector(), outStart: Top.pointOne.getVector(), outEnd: Top.pointTwo.getVector(), inHeight: Double(height)))
        }
        
        if (bottomNeighbor == nil) && (generateBottomWall)
        {
            //Add to control points to make depth? But we need them.
            
            retValWalls.append(Wall.init(inStart: Bottom.pointOne.getVector(), inEnd: Bottom.pointTwo.getVector(), outStart: Bottom.pointOne.getVector(), outEnd: Bottom.pointTwo.getVector(), inHeight: Double(height)))
        }
        
        return retValWalls
    }
    
    func get3DProjection() -> ProjectionArea3D
    {
        let leftLine3D = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: self.Left.pointOne.x, yIn: 0.0, zIn: self.Left.pointOne.y), pointTwoIn: ClayPoint3D.init(xIn: self.Left.pointTwo.x, yIn: 0.0, zIn: self.Left.pointTwo.y))
        let rightLine3D = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: self.Right.pointOne.x, yIn: 0.0, zIn: self.Right.pointOne.y), pointTwoIn: ClayPoint3D.init(xIn: self.Right.pointTwo.x, yIn: 0.0, zIn: self.Right.pointTwo.y))
        let topLine3D = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: self.Top.pointOne.x, yIn: 0.0, zIn: self.Top.pointOne.y), pointTwoIn: ClayPoint3D.init(xIn: self.Top.pointTwo.x, yIn: 0.0, zIn: self.Top.pointTwo.y))
        let bottomLine3D = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: self.Bottom.pointOne.x, yIn: 0.0, zIn: self.Bottom.pointOne.y), pointTwoIn: ClayPoint3D.init(xIn: self.Bottom.pointTwo.x, yIn: 0.0, zIn: self.Bottom.pointTwo.y))
        return ProjectionArea3D.init(left: leftLine3D, right: rightLine3D, top: topLine3D, bottom: bottomLine3D)
    }
    
    func get3DProjection(height: Float) -> ProjectionArea3D
    {
        let leftLine3D = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: self.Left.pointOne.x, yIn: height, zIn: self.Left.pointOne.y), pointTwoIn: ClayPoint3D.init(xIn: self.Left.pointTwo.x, yIn: height, zIn: self.Left.pointTwo.y))
        let rightLine3D = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: self.Right.pointOne.x, yIn: height, zIn: self.Right.pointOne.y), pointTwoIn: ClayPoint3D.init(xIn: self.Right.pointTwo.x, yIn: height, zIn: self.Right.pointTwo.y))
        let topLine3D = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: self.Top.pointOne.x, yIn: height, zIn: self.Top.pointOne.y), pointTwoIn: ClayPoint3D.init(xIn: self.Top.pointTwo.x, yIn: height, zIn: self.Top.pointTwo.y))
        let bottomLine3D = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: self.Bottom.pointOne.x, yIn: height, zIn: self.Bottom.pointOne.y), pointTwoIn: ClayPoint3D.init(xIn: self.Bottom.pointTwo.x, yIn: height, zIn: self.Bottom.pointTwo.y))
        return ProjectionArea3D.init(left: leftLine3D, right: rightLine3D, top: topLine3D, bottom: bottomLine3D)
    }
}
