//
//  AARandomWalk.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/8/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AARandomWalk: AgentAction {
    var ticker: Int = 0
    var maxWalkTime: Int = 2
    var maxWaitTime: Int = 2
    var walkSpeed: Float = 0
    var isWalking: Bool = false
    
    override func update() {
        ticker = ticker - 1
        
        if isWalking
        {
            let host = self.entityDelegate.getEntityHost()
            let unitWalkVector = TDVector3Make(0, 0, walkSpeed)
            let transformedWalkVector = TDMatrix4MultiplyVector3(TDMatrix4MakeYRotation(host.yaw), unitWalkVector)
            
            host.x = host.x + transformedWalkVector.v.0
            host.y = host.y + transformedWalkVector.v.1
            host.z = host.z + transformedWalkVector.v.2
        }
        
        if ticker < 1
        {
            let host = self.entityDelegate.getEntityHost()
            if isWalking
            {
                isWalking = false
                ticker = Int(arc4random() % UInt32(maxWaitTime))
            }
            else
            {
                isWalking = true
                ticker = Int(arc4random() % UInt32(maxWalkTime))
                host.yaw = ((Float(arc4random() & 1000))/1000.0) * Float.pi * 2.0
            }
        }
    }
}
