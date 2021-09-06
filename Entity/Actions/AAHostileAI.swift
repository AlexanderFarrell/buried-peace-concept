//
//  AAHostileAI.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 12/9/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAHostileAI: AgentAction {
    var randomWalkAction: AARandomWalk?
    var moveToPlayer: AAMoveTowardPlayer?
    var weapon: Weapon?
    
    var noticePlayerDistance: Float = 15.0
    var chaseToDistance: Float = 1.0
    var stopChasingDistance: Float = 20.0
    
    var walkSpeed: Float = 0.06
    var chaseSpeed: Float = 0.06
    
    var updateSteps = 10
    var currentUpdateStep = 0
    
    override func begin() {
        super.begin()
        
        startRandomWalk()
    }
    
    override func update() {
        if currentUpdateStep < 1
        {
            let player = self.getEntityEngine().player
            let host = self.entityDelegate.getEntityHost()
            let distance = TDVector3Distance(player!.Position(), host.Position())
            
            if randomWalkAction != nil
            {
                if distance < noticePlayerDistance
                {
                    host.endAction(action: randomWalkAction!)
                    randomWalkAction = nil
                    
                    startChasingPlayer()
                }
            }
            else
            {
                if moveToPlayer != nil
                {
                    if distance > stopChasingDistance
                    {
                        host.endAction(action: moveToPlayer!)
                        moveToPlayer = nil
                        
                        startRandomWalk()
                    }
                    
                    if distance < chaseToDistance
                    {
                        host.endAction(action: moveToPlayer!)
                        moveToPlayer = nil
                    }
                }
                else
                {
                    if distance > chaseToDistance
                    {
                        if distance > stopChasingDistance
                        {
                            startRandomWalk()
                        }
                        else
                        {
                            startChasingPlayer()
                        }
                    }
                    
                    let playerProtection = (ASProtection.GetState(entity: player!) as! ASProtection)
                    let damage = AAReceiveDamage()
                    //damage.damages.append((damageType: DamageTypeASW.Melee, strength: meleeTestStrength))
                    playerProtection.receiveDamage(receiveDamageAction: damage)
                    
                    self.getSoundEngine().playSound(soundID: "Melee001")
                    
                    //playerProtection.Health -= meleeTestStrength
                }
            }
            
            currentUpdateStep = updateSteps
        }
        else
        {
            currentUpdateStep -= 1
        }
    }
    
    func startRandomWalk()
    {
        let host = self.entityDelegate.getEntityHost()
        
        randomWalkAction = AARandomWalk()
        randomWalkAction!.walkSpeed = walkSpeed
        randomWalkAction!.maxWaitTime = 400
        randomWalkAction!.maxWalkTime = 200
        
        host.beginAction(action: randomWalkAction!)
    }
    
    func startChasingPlayer()
    {
        let host = self.entityDelegate.getEntityHost()
        
        moveToPlayer = AAMoveTowardPlayer()
        moveToPlayer!.walkSpeed = chaseSpeed
        
        host.beginAction(action: moveToPlayer!)
        
    }
}
