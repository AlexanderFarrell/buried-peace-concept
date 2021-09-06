//
//  LigamentDNA.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 12/23/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class LigamentDNA: GameplayObject {
    var meshDNAs: [ClayMesh] = [ClayMesh]()
    var projectionDNAs: [ProjectionVolume3D] = [ProjectionVolume3D]()
    var textureDNA: ClayImage!
    var startPosition: TDVector3!
    var endPosition: TDVector3!
    var upPosition: TDVector3!
    var ligamentType: LigamentType = LigamentType.Body
    var side: BodyLigamentSide = BodyLigamentSide.LeftBLS
    
    func getMesh(boneIndex: Int) -> ClayMesh
    {
        let retValClayMesh = ClayMesh()
        
        var iMeshDNA = 0
        
        assert(meshDNAs.count == projectionDNAs.count)
        
        while iMeshDNA < meshDNAs.count
        {
            projectionDNAs[iMeshDNA].projectMesh(clayMesh: meshDNAs[iMeshDNA])
            retValClayMesh.addMeshToMesh(mesh: meshDNAs[iMeshDNA])
            
            iMeshDNA += 1
        }
        
        return retValClayMesh
    }
    
    class func getProjectionsForClayCylinder(topLineOne: ClayLine3D, bottomLineOne: ClayLine3D, topLineTwo: ClayLine3D, bottomLineTwo: ClayLine3D, quadraticTopControlPointOne: TDVector3, quadraticTopControlPointTwo: TDVector3, quadraticBottomControlPointOne: TDVector3, quadraticBottomControlPointTwo: TDVector3) -> (leftProjection: ProjectionArea3D, rightProjection: ProjectionArea3D)
    {
        let topStart = topLineOne.getMidpoint()
        let bottomStart = bottomLineOne.getMidpoint()
        let topEnd = topLineTwo.getMidpoint()
        let bottomEnd = bottomLineTwo.getMidpoint()
        
        let leftTopControlPointOne = topLineOne.pointOne
        let rightTopControlPointOne = topLineOne.pointTwo
        let leftBottomControlPointOne = bottomLineOne.pointOne
        let rightBottomControlPointOne = bottomLineOne.pointTwo
        
        let leftTopControlPointTwo = topLineTwo.pointOne
        let rightTopControlPointTwo = topLineTwo.pointTwo
        let leftBottomControlPointTwo = bottomLineTwo.pointOne
        let rightBottomControlPointTwo = bottomLineTwo.pointTwo
        
        let leftStartLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: topStart), pointTwoIn: ClayPoint3D.init(vector: bottomStart), controlPointOneIn: leftTopControlPointOne.getVector(), controlPointTwoIn: leftBottomControlPointOne.getVector())
        let rightStartLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: topStart), pointTwoIn: ClayPoint3D.init(vector: bottomStart), controlPointOneIn: rightTopControlPointOne.getVector(), controlPointTwoIn: rightBottomControlPointOne.getVector())
        let leftEndLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: topEnd), pointTwoIn: ClayPoint3D.init(vector: bottomStart), controlPointOneIn: leftTopControlPointTwo.getVector(), controlPointTwoIn: leftBottomControlPointTwo.getVector())
        let rightEndLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: topEnd), pointTwoIn: ClayPoint3D.init(vector: bottomEnd), controlPointOneIn: rightTopControlPointTwo.getVector(), controlPointTwoIn: rightBottomControlPointTwo.getVector())
        
        let topLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: topStart), pointTwoIn: ClayPoint3D.init(vector: topEnd), controlPointOneIn: quadraticTopControlPointOne, controlPointTwoIn: quadraticTopControlPointTwo)
        let bottomLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: bottomStart), pointTwoIn: ClayPoint3D.init(vector: bottomEnd), controlPointOneIn: quadraticBottomControlPointOne, controlPointTwoIn: quadraticBottomControlPointTwo)
        
        let leftProjection = ProjectionArea3D.init(left: leftStartLine, right: leftEndLine, top: topLine, bottom: bottomLine)
        let rightProjection = ProjectionArea3D.init(left: rightStartLine, right: rightEndLine, top: topLine, bottom: bottomLine)
        
        let retValProjections = (leftProjection: leftProjection, rightProjection: rightProjection)
        
        return retValProjections
    }
}
