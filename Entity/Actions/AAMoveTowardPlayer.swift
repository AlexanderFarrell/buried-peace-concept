//
//  AAMoveTowardPlayer.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/8/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAMoveTowardPlayer: AgentAction {
    var walkSpeed: Float = 0.01
    
    override func update() {
        let player = self.getEntityEngine().player
        let host = self.entityDelegate.getEntityHost()
        
        let vectorToPlayer = TDVector3Subtract(host.Position(), player!.Position())
        let unitWalkVector = TDVector3Normalize(vectorToPlayer)
        let walkVector = TDVector3MultiplyScalar(unitWalkVector, walkSpeed)
        
        host.x = host.x - walkVector.v.0
        host.y = host.y - walkVector.v.1
        host.z = host.z - walkVector.v.2
    }
}
