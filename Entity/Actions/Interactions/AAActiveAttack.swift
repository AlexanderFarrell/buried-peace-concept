//
//  AAActiveAttack.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/27/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAActiveAttack: AAInteraction {
    var weapon: Weapon!
    var attack: Attack!
    var playCustomSound = true
    var assetIdentifier: String = "Default"
    var failedAction = false
    
    override func begin() {
        //It forces itself in, and pushes any other active recursive attack out
        if weapon.activeRecursiveAttack != nil
        {
            weapon.activeRecursiveAttack?.entityDelegate.getEntityHost().endAction(action: weapon.activeRecursiveAttack!)
        }
        
        weapon.activeRecursiveAttack = self
        
        super.begin()
    }
    
    override func update() {
        let host = self.entityDelegate.getEntityHost()
        let currentTarget = (ACTargeter.GetComponent(entity: host) as! ACTargeter).target
        
        if (currentTarget === target)
        {
            if weapon.activeRecursiveAttack === self
            {
                if attack!.timeLeftToAttack > 0
                {
                    attack!.timeLeftToAttack -= 1 //Do this logic on the ACEquipment
                }
                else
                {
                    attack!.timeLeftToAttack = attack!.cooldown
                    
                    let attackInteraction = AAAttack.init(interactionTypeIn: .Combat)
                    attackInteraction.target = target
                    attackInteraction.verbName = attack.name
                    attackInteraction.attack = attack
                    attackInteraction.assetIdentifier = weapon.name + attack.name
                    
                    host.beginAction(action: attackInteraction)
                    
                    attack!.timeLeftToAttack = attack!.cooldown
                    
                    if attackInteraction.failedAction
                    {
                        //host.endAction(action: attackInteraction)
                        host.endAction(action: self)
                        weapon.activeRecursiveAttack = nil
                    }
                }
            }
            else
            {
                displayMessage(message: "Attack Cancelled")
                host.endAction(action: self)
                weapon.activeRecursiveAttack = nil
            }
        }
        else
        {
            displayMessage(message: "Attack Cancelled")
            host.endAction(action: self)
            weapon.activeRecursiveAttack = nil
        }
    }
}
