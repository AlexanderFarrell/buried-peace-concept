//
//  PhysiologicalDNA.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/24/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum LigamentType {
    case Foot
    case Connector //Connects Ligaments together
    case Hand
    case Wing
    case Tail
    case Body
    case Head
}

enum BodyLigamentSide {
    case LeftBLS
    case RightBLS
}

class PhysiologicalDNA: GameplayObject {
    var ligaments: [LigamentDNA] = [LigamentDNA]()
    
    class func getHumanTestDNA() -> PhysiologicalDNA
    {
        let retValPhysiologicalDNA = PhysiologicalDNA()
        
        return retValPhysiologicalDNA
    }
    
    /*fileprivate class func getHumanHeadLigament() -> LigamentDNA
    {
        let retValLigament = LigamentDNA()
        
        var headTop: Float = 2.0
        var templeHeight: Float = 1.96
        var jawHeight: Float = 1.81
        var neckBottom: Float = 1.8
        var headBreadth: Float = 0.17
        var headExtrusion: Float = 0.13
        
        retValLigament.meshDNAs.append(ClayGeometry.createNormalizedGridMesh(width: 4, height: 4))
        
        var topHeadLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: headBreadth/2.0, yIn: templeHeight, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: -headBreadth/2.0, yIn: templeHeight, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, headTop - templeHeight, 0.0), controlPointTwoIn: TDVector3Make(0.0, headTop - templeHeight, 0.0))
        var bottomHeadLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: headBreadth/2.0, yIn: jawHeight, zIn: 0.03), pointTwoIn: ClayPoint3D.init(xIn: -headBreadth/2.0, yIn: jawHeight, zIn: 0.03), controlPointOneIn: <#T##TDVector3#>, controlPointTwoIn: <#T##TDVector3#>)
        
        var projAreas = LigamentDNA.getProjectionsForClayCylinder(topLineOne: <#T##ClayLine3D#>, bottomLineOne: <#T##ClayLine3D#>, topLineTwo: <#T##ClayLine3D#>, bottomLineTwo: <#T##ClayLine3D#>, quadraticTopControlPointOne: <#T##TDVector3#>, quadraticTopControlPointTwo: <#T##TDVector3#>, quadraticBottomControlPointOne: <#T##TDVector3#>, quadraticBottomControlPointTwo: <#T##TDVector3#>)
        retValLigament.projectionDNAs.append(Proje)
        
        return retValLigament
    }*/
}
