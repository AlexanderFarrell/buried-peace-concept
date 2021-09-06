//
//  ClaySpineNode.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/1/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class ClaySpineNode: NSObject {
    var x: Float = 0.0
    var height: Float = 0.0
    var z: Float = 0.0
    
    var upControl: TDVector3 = TDVector3Make(0.0, 1.0, 0.0)
    var upWeight: Float = 0.0
    var downControl: TDVector3 = TDVector3Make(0.0, -1.0, 0.0)
    var downWeight: Float = 0.0
    var otherControl: TDVector3 = TDVector3Make(1.0, 0.0, 0.0)
    var otherWeight: Float = 0.0
    
    var upControlXInvert: TDVector3
    {
        get
        {
            return TDVector3Make(upControl.v.0 * -1.0, upControl.v.1, upControl.v.2)
        }
    }
    
    var downControlXInvert: TDVector3
    {
        get
        {
            return TDVector3Make(downControl.v.0 * -1.0, downControl.v.1, downControl.v.2)
        }
    }
    
    var otherControlXInvert: TDVector3
    {
        get
        {
            return TDVector3Make(otherControl.v.0 * -1.0, otherControl.v.1, otherControl.v.2)
        }
    }
    
    override init() {
        super.init()
    }
    
    init(xIn: Float, heightIn: Float, zIn: Float) {
        x = xIn
        height = heightIn
        z = zIn
        
        super.init()
    }
    
    init(xIn: Float, heightIn: Float, zIn: Float, otherControlIn: TDVector3, otherWeightIn: Float) {
        x = xIn
        height = heightIn
        z = zIn
        
        otherControl = otherControlIn
        otherWeight = otherWeightIn
        
        super.init()
    }
    
    init(xIn: Float, heightIn: Float, zIn: Float, upControlIn: TDVector3, upWeightIn: Float, downControlIn: TDVector3, downWeightIn: Float) {
        x = xIn
        height = heightIn
        z = zIn
        
        upControl = upControlIn
        upWeight = upWeightIn
        downControl = downControlIn
        downWeight = downWeightIn
        
        super.init()
    }
    
    init(xIn: Float, heightIn: Float, zIn: Float, upControlIn: TDVector3, upWeightIn: Float, downControlIn: TDVector3, downWeightIn: Float, otherControlIn: TDVector3, otherWeightIn: Float) {
        x = xIn
        height = heightIn
        z = zIn
        
        upControl = upControlIn
        upWeight = upWeightIn
        downControl = downControlIn
        downWeight = downWeightIn
        otherControl = otherControlIn
        otherWeight = otherWeightIn
        
        super.init()
    }
    
    func setStraightUpDownWeights()
    {
        upControl = TDVector3Make(0.0, 1.0, 0.0)
        upWeight = 0.5
        downControl = TDVector3Make(0.0, -1.0, 0.0)
        downWeight = 0.5
    }
    
    func setStraightUpDownWeights(weight: Float)
    {
        upControl = TDVector3Make(0.0, 1.0, 0.0)
        upWeight = weight
        downControl = TDVector3Make(0.0, -1.0, 0.0)
        downWeight = weight
    }
}
