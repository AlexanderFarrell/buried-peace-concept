//
//  Wall.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/28/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Wall: GameplayObject {
    var insideStart: TDVector2
    var insideEnd: TDVector2
    var outsideStart: TDVector2
    var outsideEnd: TDVector2
    var height: Double
    
    var meshToProject: ClayMesh!
    
    init(inStart: TDVector2, inEnd: TDVector2, outStart: TDVector2, outEnd: TDVector2, inHeight: Double) {
        insideStart = inStart
        insideEnd = inEnd
        outsideStart = outStart
        outsideEnd = outEnd
        height = inHeight
    }
    
    func getFinalMesh() -> ClayMesh
    {
        let projection = getProjection()
        projection.projectMesh(clayMesh: meshToProject)
        
        return meshToProject
    }
    
    private func getProjection() -> ProjectionVolume3D
    {
        let proInTopLeft = TDVector3Make(insideStart.v.0, Float(height), insideStart.v.1)
        let proInTopRight = TDVector3Make(insideEnd.v.0, Float(height), insideEnd.v.1)
        let proInBottomLeft = TDVector3Make(insideStart.v.0, 0.0, insideStart.v.1)
        let proInBottomRight = TDVector3Make(insideEnd.v.0, 0.0, insideEnd.v.1)
        let projectionInside = ProjectionArea3D.init(topLeft: proInTopLeft, topRight: proInTopRight, bottomLeft: proInBottomLeft, bottomRight: proInBottomRight)
        
        let proOutTopLeft = TDVector3Make(outsideStart.v.0, Float(height), outsideStart.v.1)
        let proOutTopRight = TDVector3Make(outsideEnd.v.0, Float(height), outsideEnd.v.1)
        let proOutBottomLeft = TDVector3Make(outsideStart.v.0, 0.0, outsideStart.v.1)
        let proOutBottomRight = TDVector3Make(outsideEnd.v.0, 0.0, outsideEnd.v.1)
        let projectionOutside = ProjectionArea3D.init(topLeft: proOutTopLeft, topRight: proOutTopRight, bottomLeft: proOutBottomLeft, bottomRight: proOutBottomRight)
        
        let retValProjectionVolume = ProjectionVolume3D.init(insideSurface: projectionInside, outsideSurface: projectionOutside)
        
        return retValProjectionVolume
    }
}
