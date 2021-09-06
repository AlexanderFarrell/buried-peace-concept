//
//  ClayHumanMesh.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/1/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class ClayHumanMesh: NSObject {
    class func generateBasicSpineHuman(dna: ClayHumanMeshDNA) -> ClayMesh
    {
        var retVal = ClayMesh()
        
        //Get the measurements of the body parts
        
        /*var stature = dna.stature
        
        var altitudeForehead = dna.altitudeForehead
        var altitudeChin = dna.altitudeChin
        var altitudeTopNeck = dna.altitudeTopNeck
        var altitudeBottomNeck = dna.altitudeBottomNeck
        var altitudeTopShoulder = dna.altitudeTopShoulder
        var altitudeInterscye = dna.altitudeInterscye
        var altitudeWaist = dna.altitudeWaist
        var altitudePerineum = dna.altitudePerineum
        var altitudeKnee = dna.altitudeKnee
        var altitudeAnkle = dna.altitudeAnkle
        
        var altitudeTopWrist = dna.altitudeTopWrist
        var altitudeBottomWrist = dna.altitudeBottomWrist
        
        var breadthForehead = dna.breadthForehead
        var breadthChin = dna.breadthChin
        var breadthNeckTop = dna.breadthNeckTop
        var breadthNeckBottom = dna.breadthNeckBottom
        var breadthShoulder = dna.breadthShoulder
        var breadthInterscye = dna.breadthInterscye
        var breadthWaist = dna.breadthWaist
        var breadthPerineum = dna.breadthPerineum
        var anklesWidthApart = dna.anklesWidthApart
        var breadthLeg = dna.breadthLeg
        
        var armToShoulderLength = dna.armToShoulderLength
        var upperArmLength = dna.upperArmLength
        var lowerArmLength = dna.lowerArmLength
        var handLength = dna.handLength
        
        //Create the Double spine for the body and head
        var doubleSpine = ClayDoubleSpine.init(stature: stature, direction: TDVector3Make(0.0, 1.0, 0.0), origin: TDVector3Make(0.0, 0.0, 0.0))
        
        let scalpOut = ClaySpineNode.init(xIn: 0.0, heightIn: 0.0, zIn: 0.0)
        scalpOut.downControl = TDVector3Make(1.0, 0.0, 0.0)
        scalpOut.downWeight = 0.5
        doubleSpine.addNode(outside: scalpOut, inside: scalpOut)
        
        let foreheadOut = ClaySpineNode.init(xIn: breadthForehead/2.0, heightIn: altitudeForehead, zIn: 0.0)
        foreheadOut.setStraightUpDownWeights()
        //let foreheadFront = ClaySpineNode.init(xIn: <#T##Float#>, heightIn: <#T##Float#>, zIn: <#T##Float#>)
        
        
        return retVal
    }
    
    class func generateBasicHumanoid(dna: ClayHumanMeshDNA) -> ClayMesh
    {
        var retVal = ClayMesh()
        
        //Get the measurements of the body parts
        
        var stature = dna.stature
        
        var altitudeForehead = dna.altitudeForehead
        var altitudeChin = dna.altitudeChin
        var altitudeTopNeck = dna.altitudeTopNeck
        var altitudeBottomNeck = dna.altitudeBottomNeck
        var altitudeTopShoulder = dna.altitudeTopShoulder
        var altitudeInterscye = dna.altitudeInterscye
        var altitudeWaist = dna.altitudeWaist
        var altitudePerineum = dna.altitudePerineum
        var altitudeKnee = dna.altitudeKnee
        var altitudeAnkle = dna.altitudeAnkle
        
        var altitudeTopWrist = dna.altitudeTopWrist
        var altitudeBottomWrist = dna.altitudeBottomWrist
        
        var breadthForehead = dna.breadthForehead
        var breadthChin = dna.breadthChin
        var breadthNeckTop = dna.breadthNeckTop
        var breadthNeckBottom = dna.breadthNeckBottom
        var breadthShoulder = dna.breadthShoulder
        var breadthInterscye = dna.breadthInterscye
        var breadthWaist = dna.breadthWaist
        var breadthPerineum = dna.breadthPerineum
        var anklesWidthApart = dna.anklesWidthApart
        var breadthLeg = dna.breadthLeg
        
        var armToShoulderLength = dna.armToShoulderLength
        var upperArmLength = dna.upperArmLength
        var lowerArmLength = dna.lowerArmLength
        var handLength = dna.handLength
        
        //Multiply all of the normalized measurements by the stature
        
        altitudeForehead *= stature
        altitudeChin *= stature
        altitudeTopNeck *= stature
        altitudeBottomNeck *= stature
        altitudeTopShoulder *= stature
        altitudeInterscye *= stature
        altitudeWaist *= stature
        altitudePerineum *= stature
        altitudeKnee *= stature
        altitudeAnkle *= stature
        
        altitudeTopWrist *= stature
        altitudeBottomWrist *= stature
        
        breadthForehead *= stature
        breadthChin *= stature
        breadthNeckTop *= stature
        breadthNeckBottom *= stature
        breadthShoulder *= stature
        breadthInterscye *= stature
        breadthWaist *= stature
        breadthPerineum *= stature
        anklesWidthApart *= stature
        breadthLeg *= stature
        
        breadthInterscye = breadthShoulder
        
        upperArmLength *= stature
        lowerArmLength *= stature
        handLength *= stature
        armToShoulderLength *= stature
        
        //Make the curves
        //TODO: Parameterize the control point data. It's not normalized, so we can multiply it by the stature.
        //TODO: Constant the points of the body
        //TODO: Flip the direction of the back curves so the normals end up correct, and for culling
        
        //Head
        let chinFrontCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthChin/2.0, yIn: altitudeChin, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthChin/2.0, yIn: altitudeChin, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.15), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.15))
        let chinBackCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthChin/2.0, yIn: altitudeChin, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthChin/2.0, yIn: altitudeChin, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.07), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.07))
        let foreheadFrontCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.05), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.05))
        let foreheadBackCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.05), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.05))
        let chinToNeckLeftCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthChin/2.0, yIn: altitudeChin, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: -breadthNeckTop/2.0, yIn: altitudeTopNeck, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, -0.01, 0.0), controlPointTwoIn: TDVector3Make(0.0, 0.01, 0.0))
        let chinToNeckRightCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthChin/2.0, yIn: altitudeChin, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthNeckTop/2.0, yIn: altitudeTopNeck, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, -0.01, 0.0), controlPointTwoIn: TDVector3Make(0.0, 0.01, 0.0))
        
        let foreheadToChinLeftCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: -breadthChin/2.0, yIn: altitudeChin, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, -0.01, 0.0), controlPointTwoIn: TDVector3Make(0.0, 0.01, 0.0))
        let foreheadToChinRightCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthChin/2.0, yIn: altitudeChin, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, -0.01, 0.0), controlPointTwoIn: TDVector3Make(0.0, 0.01, 0.0))
        
        let scalpCrossoverCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.02, 0.0), controlPointTwoIn: TDVector3Make(0.0, 0.02, 0.0))
        let scalpLeftPoint = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: -breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.0), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.0))
        let scalpRightPoint = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthForehead/2.0, yIn: altitudeForehead, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.0), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.0))
        
        //Neck
        let neckTopFrontCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthNeckTop/2.0, yIn: altitudeTopNeck, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthNeckTop/2.0, yIn: altitudeTopNeck, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.05), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.05))
        let neckTopBackCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthNeckTop/2.0, yIn: altitudeTopNeck, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthNeckTop/2.0, yIn: altitudeTopNeck, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.05), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.05))
        let neckBottomFrontCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthNeckBottom/2.0, yIn: altitudeBottomNeck, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthNeckBottom/2.0, yIn: altitudeBottomNeck, zIn: 0.0), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(-0.3, -0.2, 1.0)), 0.06), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(0.3, -0.2, 1.0)), 0.06))
        let neckBottomBackCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthNeckBottom/2.0, yIn: altitudeBottomNeck, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthNeckBottom/2.0, yIn: altitudeBottomNeck, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.06), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.06))
        
        let neckSideLeftCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthNeckTop/2.0, yIn: altitudeTopNeck, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: -breadthNeckBottom/2.0, yIn: altitudeBottomNeck, zIn: 0.0), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(-0.3, -1.0, 0.0)), 0.01), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(-0.3, 0.7, 0.0)), 0.01))
        let neckSideRightCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthNeckTop/2.0, yIn: altitudeTopNeck, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthNeckBottom/2.0, yIn: altitudeBottomNeck, zIn: 0.0), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(0.3, -1.0, 0.0)), 0.01), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(0.3, 0.7, 0.0)), 0.01))
        
        //Neck to Chest
        let neckLowerSideLeftCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthNeckBottom/2.0, yIn: altitudeBottomNeck, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: -breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(0.3, -0.7, 0.0)), 0.03), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(0.6, 0.4, 0.0)), 0.025))
        let neckLowerSideRightCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthNeckBottom/2.0, yIn: altitudeBottomNeck, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(-0.3, -0.7, 0.0)), 0.03), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(TDVector3Make(-0.6, 0.4, 0.0)), 0.025))
        
        //Chest
        let chestTopFrontCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.1), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.1))
        let chestTopBackCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.1), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.1))
        let chestBottomFrontCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthInterscye/2.0, yIn: altitudeInterscye, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthInterscye/2.0, yIn: altitudeInterscye, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.1), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.1))
        let chestBottomBackCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthInterscye/2.0, yIn: altitudeInterscye, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthInterscye/2.0, yIn: altitudeInterscye, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.1), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.1))
        
        let chestSideLeftFrontCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: -breadthInterscye/2.0, yIn: altitudeInterscye, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.05), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.05))
        let chestSideRightFrontCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthInterscye/2.0, yIn: altitudeInterscye, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.05), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.05))
        let chestSideLeftBackCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: -breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: -breadthInterscye/2.0, yIn: altitudeInterscye, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.05), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.05))
        let chestSideRightBackCurve = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthShoulder/2.0, yIn: altitudeTopShoulder, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: breadthInterscye/2.0, yIn: altitudeInterscye, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.05), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.05))
        
        //Right Arm
        let rightFrontWrist = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: (upperArmLength + lowerArmLength) + (breadthShoulder/2.0), yIn: altitudeTopWrist/*TODO: add indent amount for wrist */, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: (upperArmLength + lowerArmLength) + (breadthShoulder/2.0), yIn: altitudeBottomWrist, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.02), controlPointTwoIn: TDVector3Make(0.0, 0.0, 0.02))
        let rightBackWrist = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: (upperArmLength + lowerArmLength) + (breadthShoulder/2.0), yIn: altitudeTopWrist/*TODO: add indent amount for wrist */, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: (upperArmLength + lowerArmLength) + (breadthShoulder/2.0), yIn: altitudeBottomWrist, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.02), controlPointTwoIn: TDVector3Make(0.0, 0.0, -0.02))
        let rightFrontElbow = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: upperArmLength + (breadthShoulder/2.0), yIn: altitudeTopWrist, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: upperArmLength + (breadthShoulder/2.0), yIn: altitudeBottomWrist, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, 0.02), controlPointTwoIn: TDVector3Normalize(TDVector3Make(0.0, 0.0, 0.02)))
        let rightBackElbow = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: upperArmLength + (breadthShoulder/2.0), yIn: altitudeTopWrist, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: upperArmLength + (breadthShoulder/2.0), yIn: altitudeBottomWrist, zIn: 0.0), controlPointOneIn: TDVector3Make(0.0, 0.0, -0.02), controlPointTwoIn: TDVector3Normalize(TDVector3Make(0.0, 0.0, -0.02)))
        let rightUpperArmLineTop = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthShoulder/2.0, yIn: altitudeTopWrist, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: upperArmLength + (breadthShoulder/2.0), yIn: altitudeTopWrist, zIn: 0.0), controlPointOneIn: TDVector3Make(0.09, 0.0, 0.0), controlPointTwoIn: TDVector3Make(-0.09, 0.0, 0.0))
        let rightUpperArmLineBottom = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthShoulder/2.0, yIn: altitudeBottomWrist, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: upperArmLength + (breadthShoulder/2.0), yIn: altitudeBottomWrist, zIn: 0.0), controlPointOneIn: TDVector3Make(0.09, 0.0, 0.0), controlPointTwoIn: TDVector3Make(-0.09, 0.0, 0.0))
        let rightLowerArmLineTop = ClayLine3D.init(pointOneIn: ClayPoint3D.init(xIn: breadthShoulder/2.0, yIn: altitudeTopWrist, zIn: 0.0), pointTwoIn: ClayPoint3D.init(xIn: upperArmLength + (breadthShoulder/2.0), yIn: altitudeTopWrist, zIn: 0.0), controlPointOneIn: TDVector3Make(0.09, 0.0, 0.0), controlPointTwoIn: TDVector3Make(-0.09, 0.0, 0.0))*/
        
        
        
        
        
        
        
        return retVal
    }
}












