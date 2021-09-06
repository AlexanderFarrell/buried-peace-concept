//
//  AAGiveDamageTest.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/10/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAGiveDamageTest: AAInteraction {
    var damage: AAReceiveDamage?
    var playCustomSound = true
    var sound: String = "Laser"
    var assetIdentifier: String = "Default"
    
    override init(interactionTypeIn: InteractionTypesEntity) {
        super.init(interactionTypeIn: interactionTypeIn)
        
        self.verbName = "Attack"
        self.progressiveName = "Attacking"
    }
    
    override func begin() {
        super.begin()
        
        let physics = getPhysics()
        
        if physics.isLineValid(start: self.entityDelegate.getEntityHost().Position(), end: self.target!.Position(), checkPer: 1.0)
        {
            //let protection = (ASProtection.GetState(entity: target!) as! ASProtection)
            
            self.getSoundEngine().playSound(soundID: sound)
            
            if (damage != nil)
            {
                //protection.receiveDamage(receiveDamageAction: damage!)
                
                let projectile = Projectile()
                projectile.targeter = self.entityDelegate.getEntityHost()
                projectile.target = target!
                projectile.actionToGive = damage!
                projectile.identifier = assetIdentifier
            }
        }
        else
        {
            if self.entityDelegate.getEntityHost() is Player
            {
                displayMessage(message: "Line of sight to target obstructed. Cannot fire weapon.")
            }
        }
        
        self.entityDelegate.getEntityHost().endAction(action: self)
    }
}
