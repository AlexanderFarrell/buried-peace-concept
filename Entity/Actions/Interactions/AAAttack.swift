//
//  AAAttack.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/18/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAAttack: AAInteraction {
    var attack: Attack?
    var playCustomSound = true
    var assetIdentifier: String = "Default"
    var failedAction = false
    
    override init(interactionTypeIn: InteractionTypesEntity) {
        super.init(interactionTypeIn: interactionTypeIn)
        
        self.verbName = "Attack"
        self.progressiveName = "Attacking"
    }
    
    override func begin() {
        super.begin()
        
        var failPrintMessage: String? = nil
        
        if ((attack != nil) && (target != nil))
        {
            let distance = Double(TDVector3Distance(self.entityDelegate.getEntityHost().Position(), self.target!.Position()))
            
            if (distance >= attack!.minimumDistance)
            {
                if (distance <= attack!.maximumDistance)
                {
                    let physics = getPhysics()
                    
                    if physics.isLineValid(start: self.entityDelegate.getEntityHost().Position(), end: self.target!.Position(), checkPer: 1.0)
                    {
                        //let protection = (ASProtection.GetState(entity: target!) as! ASProtection)
                        
                        if attack!.soundWhenFired != nil
                        {
                            self.getSoundEngine().playSound(soundID: attack!.soundWhenFired!)
                        }
                        
                        let damage = AAReceiveDamage()
                        damage.addDamage(damageType: attack!.damageType, strength: attack!.strength)
                        
                        let projectile = Projectile()
                        projectile.targeter = self.entityDelegate.getEntityHost()
                        projectile.target = target!
                        projectile.actionToGive = damage
                        projectile.identifier = assetIdentifier
                        projectile.trajectory = attack!.projectileTrajectory
                        self.getEntityEngine().addEntity(entity: projectile)
                        //protection.receiveDamage(receiveDamageAction: damage)
                    }
                    else
                    {
                        failPrintMessage = "I cannot see the target."
                    }
                }
                else
                {
                    failPrintMessage = "I'm too far away to " + attack!.name.capitalized
                }
            }
            else
            {
                failPrintMessage = "I'm too close to " + attack!.name.capitalized
            }
            
            self.entityDelegate.getEntityHost().endAction(action: self)
        }
        
        if failPrintMessage != nil
        {
            failedAction = true
            
            if self.entityDelegate.getEntityHost() is Player
            {
                displayMessage(message: failPrintMessage!)
            }
        }
    }
}
