//
//  CaveSquare.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/11/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class CaveSquare: NSObject {
    var x: Int = 0
    var y: Int = 0
    
    var renderBaseGeometry: Bool = true
    var floorTexture: Int = 0
    var ceilTexture: Int = 0
    
    var exists: Bool = true
    var passable: Bool = false
    var buildable: Bool = false
    
    var exceptionAltitude: Bool = false
    
    var floorAltitudex0y0: Float = 0.0
    var floorAltitudex1y0: Float = 0.0
    var floorAltitudex0y1: Float = 0.0
    var floorAltitudex1y1: Float = 0.0
    
    var ceilingAltitudex0y0: Float = 20.0
    var ceilingAltitudex1y0: Float = 20.0
    var ceilingAltitudex0y1: Float = 20.0
    var ceilingAltitudex1y1: Float = 20.0
    
    var wallFloorToCeilIndex: Int = 0
    var wallExceptionIndex: Int = 0
    
    var walls: [CaveWall] = [CaveWall]()
    var layers: [CaveSquareLayerSer]?
    
    var liquid: LiquidCaveSquare?
    
    init(serializable: CaveSquareSer) {
        //TODO: Implement
        exists = true
        
        floorAltitudex0y0 = serializable.floorAltitudex0y0
        floorAltitudex0y1 = serializable.floorAltitudex0y1
        floorAltitudex1y0 = serializable.floorAltitudex1y0
        floorAltitudex1y1 = serializable.floorAltitudex1y1
        
        ceilingAltitudex0y0 = serializable.ceilingAltitudex0y0
        ceilingAltitudex0y1 = serializable.ceilingAltitudex0y1
        ceilingAltitudex1y0 = serializable.ceilingAltitudex1y0
        ceilingAltitudex1y1 = serializable.ceilingAltitudex1y1
        
        wallFloorToCeilIndex = serializable.wallFloorToCeilIndex
        wallExceptionIndex = serializable.wallExceptionIndex
        
        floorTexture = serializable.floorTexture
        ceilTexture = serializable.ceilTexture
        
        super.init()
    }
    
    override init() {
        exists = false
        super.init()
    }
    
    func getSerializable() -> CaveSquareSer
    {
        var retVal = CaveSquareSer.init()
        retVal.floorAltitudex0y0 = floorAltitudex0y0
        retVal.floorAltitudex0y1 = floorAltitudex0y1
        retVal.floorAltitudex1y0 = floorAltitudex1y0
        retVal.floorAltitudex1y1 = floorAltitudex1y1
        
        retVal.ceilingAltitudex0y0 = ceilingAltitudex0y0
        retVal.ceilingAltitudex0y1 = ceilingAltitudex0y1
        retVal.ceilingAltitudex1y0 = ceilingAltitudex1y0
        retVal.ceilingAltitudex1y1 = ceilingAltitudex1y1
        
        retVal.wallFloorToCeilIndex = wallFloorToCeilIndex
        retVal.wallExceptionIndex = wallExceptionIndex
        
        retVal.floorTexture = floorTexture
        retVal.ceilTexture = ceilTexture
        
        retVal.x = x
        retVal.y = y
        
        return retVal
    }
    
    func setToHeightMap(floor: ClayHeightMap, ceiling: ClayHeightMap)
    {
        if !exceptionAltitude
        {
            floorAltitudex0y0 = floor.altitude[x][y]
            floorAltitudex1y0 = floor.altitude[x + 1][y]
            floorAltitudex0y1 = floor.altitude[x][y + 1]
            floorAltitudex1y1 = floor.altitude[x + 1][y + 1]
            
            ceilingAltitudex0y0 = ceiling.altitude[x][y]
            ceilingAltitudex1y0 = ceiling.altitude[x + 1][y]
            ceilingAltitudex0y1 = ceiling.altitude[x][y + 1]
            ceilingAltitudex1y1 = ceiling.altitude[x + 1][y + 1]
        }
    }
    
    func addToMeshes(meshesToTexture: Dictionary<Int, ClayMesh>) -> Dictionary<Int, ClayMesh>
    {
        var meshesByTexture = meshesToTexture
        
        //Test Method Floors
        if meshesByTexture[floorTexture] == nil
        {
            meshesByTexture[floorTexture] = ClayMesh()
        }
        
        let floatSquareSize = Float(Constants.squareSize)
        
        let vertexOne = ClayVertex()
        vertexOne.position = TDVector3Make(Float(x) * floatSquareSize, floorAltitudex0y0, Float(y) * floatSquareSize)
        vertexOne.textureCoordinate = TDVector2Make(0.0, 0.0)
        
        let vertexTwo = ClayVertex()
        vertexTwo.position = TDVector3Make(Float(x + 1) * floatSquareSize, floorAltitudex1y0, Float(y) * floatSquareSize)
        vertexTwo.textureCoordinate = TDVector2Make(1.0, 0.0)
        
        let vertexThree = ClayVertex()
        vertexThree.position = TDVector3Make(Float(x) * floatSquareSize, floorAltitudex0y1, Float(y + 1) * floatSquareSize)
        vertexThree.textureCoordinate = TDVector2Make(0.0, 1.0)
        
        let vertexFour = ClayVertex()
        vertexFour.position = TDVector3Make(Float(x + 1) * floatSquareSize, floorAltitudex1y1, Float(y + 1) * floatSquareSize)
        vertexFour.textureCoordinate = TDVector2Make(1.0, 1.0)
        
        let indexOffset = meshesByTexture[0]!.vertices.count
        
        meshesByTexture[floorTexture]!.vertices.append(vertexOne)
        meshesByTexture[floorTexture]!.vertices.append(vertexTwo)
        meshesByTexture[floorTexture]!.vertices.append(vertexThree)
        meshesByTexture[floorTexture]!.vertices.append(vertexFour)
        
        meshesByTexture[floorTexture]!.indices.append(UInt32(0 + indexOffset))
        meshesByTexture[floorTexture]!.indices.append(UInt32(1 + indexOffset))
        meshesByTexture[floorTexture]!.indices.append(UInt32(2 + indexOffset))
        meshesByTexture[floorTexture]!.indices.append(UInt32(1 + indexOffset))
        meshesByTexture[floorTexture]!.indices.append(UInt32(2 + indexOffset))
        meshesByTexture[floorTexture]!.indices.append(UInt32(3 + indexOffset))
        
        if floorTexture != ceilTexture
        {
            if meshesByTexture[ceilTexture] == nil
            {
                meshesByTexture[ceilTexture] = ClayMesh()
            }
        }
        
        //Test Method Ceiling
        let vertexOneC = ClayVertex()
        vertexOneC.position = TDVector3Make(Float(x) * floatSquareSize, ceilingAltitudex0y0, Float(y) * floatSquareSize)
        vertexOneC.textureCoordinate = TDVector2Make(0.0, 0.0)
        
        let vertexTwoC = ClayVertex()
        vertexTwoC.position = TDVector3Make(Float(x + 1) * floatSquareSize, ceilingAltitudex1y0, Float(y) * floatSquareSize)
        vertexTwoC.textureCoordinate = TDVector2Make(1.0, 0.0)
        
        let vertexThreeC = ClayVertex()
        vertexThreeC.position = TDVector3Make(Float(x) * floatSquareSize, ceilingAltitudex0y1, Float(y + 1) * floatSquareSize)
        vertexThreeC.textureCoordinate = TDVector2Make(0.0, 1.0)
        
        let vertexFourC = ClayVertex()
        vertexFourC.position = TDVector3Make(Float(x + 1) * floatSquareSize, ceilingAltitudex1y1, Float(y + 1) * floatSquareSize)
        vertexFourC.textureCoordinate = TDVector2Make(1.0, 1.0)
        
        let indexOffsetC = meshesByTexture[0]!.vertices.count
        
        meshesByTexture[ceilTexture]!.vertices.append(vertexOneC)
        meshesByTexture[ceilTexture]!.vertices.append(vertexTwoC)
        meshesByTexture[ceilTexture]!.vertices.append(vertexThreeC)
        meshesByTexture[ceilTexture]!.vertices.append(vertexFourC)
        
        meshesByTexture[ceilTexture]!.indices.append(UInt32(0 + indexOffsetC))
        meshesByTexture[ceilTexture]!.indices.append(UInt32(1 + indexOffsetC))
        meshesByTexture[ceilTexture]!.indices.append(UInt32(2 + indexOffsetC))
        meshesByTexture[ceilTexture]!.indices.append(UInt32(1 + indexOffsetC))
        meshesByTexture[ceilTexture]!.indices.append(UInt32(2 + indexOffsetC))
        meshesByTexture[ceilTexture]!.indices.append(UInt32(3 + indexOffsetC))
        
        if walls.count > 0
        {
            var iWall = 0
            
            while iWall < walls.count
            {
                let wall = walls[iWall]
                let wallTexture = wall.textureIndex
                
                if meshesByTexture[wallTexture] == nil
                {
                    meshesByTexture[wallTexture] = ClayMesh()
                }
                
                let vertexOneW = ClayVertex()
                vertexOneW.position = TDVector3Make(wall.xStart * floatSquareSize, wall.topStart, wall.yStart * floatSquareSize)
                vertexOneW.textureCoordinate = TDVector2Make(0.0, 0.0)
                
                let vertexTwoW = ClayVertex()
                vertexTwoW.position = TDVector3Make(wall.xStart * floatSquareSize, wall.baseStart, wall.yStart * floatSquareSize)
                vertexTwoW.textureCoordinate = TDVector2Make(1.0, 0.0)
                
                let vertexThreeW = ClayVertex()
                vertexThreeW.position = TDVector3Make(wall.xEnd * floatSquareSize, wall.topEnd, wall.yEnd * floatSquareSize)
                vertexThreeW.textureCoordinate = TDVector2Make(0.0, 1.0)
                
                let vertexFourW = ClayVertex()
                vertexFourW.position = TDVector3Make(wall.xEnd * floatSquareSize, wall.baseEnd, wall.yEnd * floatSquareSize)
                vertexFourW.textureCoordinate = TDVector2Make(1.0, 1.0)
                
                let indexOffsetW = meshesByTexture[0]!.vertices.count
                
                meshesByTexture[wallTexture]!.vertices.append(vertexOneW)
                meshesByTexture[wallTexture]!.vertices.append(vertexTwoW)
                meshesByTexture[wallTexture]!.vertices.append(vertexThreeW)
                meshesByTexture[wallTexture]!.vertices.append(vertexFourW)
                
                meshesByTexture[wallTexture]!.indices.append(UInt32(0 + indexOffsetW))
                meshesByTexture[wallTexture]!.indices.append(UInt32(1 + indexOffsetW))
                meshesByTexture[wallTexture]!.indices.append(UInt32(2 + indexOffsetW))
                meshesByTexture[wallTexture]!.indices.append(UInt32(1 + indexOffsetW))
                meshesByTexture[wallTexture]!.indices.append(UInt32(2 + indexOffsetW))
                meshesByTexture[wallTexture]!.indices.append(UInt32(3 + indexOffsetW))
                
                iWall += 1
            }
        }
        
        return meshesByTexture
        
        //Maybe we can add some variety to the mesh. Like instead of just being two triangles for a generic floor, make it rocky. Add rocks to the thing or make it more than a triangle.
        //Just don't go over a few centimeters in detail. Otherwise it will look like the player is off.
    }
    
    func addWalls(map: Dictionary<Int, Dictionary<Int, CaveSquare>>)
    {        
        //Add Floor to Ceiling Walls
        //Check if their is a tile. If not, we add a wall
        if map[x - 1]?[y] == nil
        {
            //Add left wall
            let wall = CaveWall()
            wall.xStart = Float(x)
            wall.xEnd = Float(x)
            
            wall.yStart = Float(y)
            wall.yEnd = Float(y + 1)
            
            wall.baseStart = floorAltitudex0y0
            wall.baseEnd = floorAltitudex0y1
            
            wall.topStart = ceilingAltitudex0y0
            wall.topEnd = ceilingAltitudex0y1
            
            wall.textureIndex = wallFloorToCeilIndex
            
            walls.append(wall)
        }
        
        if map[x + 1]?[y] == nil
        {
            //Add right wall
            let wall = CaveWall()
            wall.xStart = Float(x + 1)
            wall.xEnd = Float(x + 1)
            
            wall.yStart = Float(y)
            wall.yEnd = Float(y + 1)
            
            wall.baseStart = floorAltitudex1y0
            wall.baseEnd = floorAltitudex1y1
            
            wall.topStart = ceilingAltitudex1y0
            wall.topEnd = ceilingAltitudex1y1
            
            wall.textureIndex = wallFloorToCeilIndex
            
            walls.append(wall)
        }
        
        if map[x]?[y - 1] == nil
        {
            //Add forward wall
            let wall = CaveWall()
            wall.xStart = Float(x)
            wall.xEnd = Float(x + 1)
            
            wall.yStart = Float(y)
            wall.yEnd = Float(y)
            
            wall.baseStart = floorAltitudex0y0
            wall.baseEnd = floorAltitudex1y0
            
            wall.topStart = ceilingAltitudex0y0
            wall.topEnd = ceilingAltitudex1y0
            
            wall.textureIndex = wallFloorToCeilIndex
            
            walls.append(wall)
        }
        
        if map[x]?[y + 1] == nil
        {
            //Add backward wall
            let wall = CaveWall()
            wall.xStart = Float(x)
            wall.xEnd = Float(x + 1)
            
            wall.yStart = Float(y + 1)
            wall.yEnd = Float(y + 1)
            
            wall.baseStart = floorAltitudex0y1
            wall.baseEnd = floorAltitudex1y1
            
            wall.topStart = ceilingAltitudex0y1
            wall.topEnd = ceilingAltitudex1y1
            
            wall.textureIndex = wallFloorToCeilIndex
            
            walls.append(wall)
        }
    }
    
    func setAllAltitude(altitude: Float)
    {
        floorAltitudex0y0 = altitude
        floorAltitudex1y0 = altitude
        floorAltitudex0y1 = altitude
        floorAltitudex1y1 = altitude
    }
    
    func setAllCeilAltitude(altitude: Float)
    {
        ceilingAltitudex0y0 = altitude
        ceilingAltitudex1y0 = altitude
        ceilingAltitudex0y1 = altitude
        ceilingAltitudex1y1 = altitude
    }
}
