//
//  ClayHumanMeshDNA.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/1/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class ClayHumanMeshDNA: NSObject {
    var stature: Float = 1.799
    
    var altitudeForehead: Float = 0.0
    var altitudeChin: Float = 0.0
    var altitudeTopNeck: Float = 0.0
    var altitudeBottomNeck: Float = 0.0
    var altitudeTopShoulder: Float = 0.0
    var altitudeInterscye: Float = 0.0
    var altitudeWaist: Float = 0.0
    var altitudePerineum: Float = 0.0
    var altitudeKnee: Float = 0.0
    var altitudeAnkle: Float = 0.0
    var altitudeTopWrist: Float = 0.0
    var altitudeBottomWrist: Float = 0.0
    
    var breadthForehead: Float = 0.0
    var breadthChin: Float = 0.0
    var breadthNeckTop: Float = 0.0
    var breadthNeckBottom: Float = 0.0
    var breadthShoulder: Float = 0.0
    var breadthInterscye: Float = 0.0
    var breadthWaist: Float = 0.0
    var breadthPerineum: Float = 0.0
    var anklesWidthApart: Float = 0.0
    var breadthLeg: Float = 0.0
    
    var armToShoulderLength: Float = 0.0
    var upperArmLength: Float = 0.0
    var lowerArmLength: Float = 0.0
    var handLength: Float = 0.0
    
    class func getDNAAverageAdultMale() -> ClayHumanMeshDNA
    {
        let retVal = ClayHumanMeshDNA()
        
        retVal.stature = 1.759//Based on www.ele.uri.edu/faculty/vetter/BME207/anthropometric-data.pdf, stature is actually 1.759//1.799
        
        retVal.altitudeForehead = 0.97702587
        retVal.altitudeChin = 0.870
        retVal.altitudeTopNeck = 0.860
        retVal.altitudeBottomNeck = 0.845
        retVal.altitudeTopShoulder = 0.818
        retVal.altitudeInterscye = 0.720
        retVal.altitudeWaist = 0.530
        retVal.altitudePerineum = 0.485
        retVal.altitudeKnee = 0.285
        retVal.altitudeAnkle = 0.039
        retVal.altitudeBottomWrist = 0.720
        
        retVal.breadthForehead = 0.08125000021013 //To Be Replaced
        retVal.breadthChin = 0.08125000021013 //To Be Replaced
        retVal.breadthNeckTop = 0.074154
        retVal.breadthNeckBottom = 0.094154
        retVal.breadthShoulder = 0.259
        retVal.breadthInterscye = 0.174
        retVal.breadthWaist = 0.191
        retVal.breadthPerineum = 0.00401
        retVal.anklesWidthApart = 0.00401
        retVal.breadthLeg = 0.0907
        
        retVal.armToShoulderLength = 0.44
        retVal.upperArmLength = 0.186
        retVal.lowerArmLength = 0.146
        retVal.handLength = 0.108
        
        return retVal
    }
    
    class func getDNAAverageAdultFemale() -> ClayHumanMeshDNA
    {
        //Data based on www.ele.uri.edu/faculty/vetter/BME207/anthropometric-data.pdf
        //Get different data if this cannot be used commercially
        
        let retVal = ClayHumanMeshDNA()
        
        retVal.stature = 1.618
        
        retVal.altitudeForehead = 0.9394313967861557
        retVal.altitudeChin = 0.875
        retVal.altitudeTopNeck = 0.860 //Need, perhaps artistically make closer to chin
        retVal.altitudeBottomNeck = 0.845 //Need
        retVal.altitudeTopShoulder = 0.825
        retVal.altitudeInterscye = 0.720 //Need
        retVal.altitudeWaist = 0.6087762669962917
        retVal.altitudePerineum = 0.524
        retVal.altitudeKnee = 0.282
        retVal.altitudeAnkle = 0.048
        retVal.altitudeBottomWrist = 0.720 //Need, same as Interscye
        
        retVal.breadthForehead = 0.08125000021013 //To Be Replaced
        retVal.breadthChin = 0.08125000021013 //To Be Replaced
        retVal.breadthNeckTop = 0.074154 //Need
        retVal.breadthNeckBottom = 0.094154 //Need
        retVal.breadthShoulder = 0.245
        retVal.breadthInterscye = 0.172
        retVal.breadthWaist = 0.219 //Need
        retVal.breadthPerineum = 0.00401 //Need
        retVal.anklesWidthApart = 0.00401 //Need
        retVal.breadthLeg = 0.0907 //Need
        
        retVal.armToShoulderLength = 0.455
        retVal.upperArmLength = 0.193
        retVal.lowerArmLength = 0.172
        retVal.handLength = 0.09
        
        return retVal
    }
}















