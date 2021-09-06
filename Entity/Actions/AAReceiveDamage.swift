//
//  AAReceiveDamage.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAReceiveDamage: AgentAction {
    var damages = [(damageType: DamageTypeASW, strength: Double)]()
    
    override func begin() {
        let protection = ASProtection.GetState(entity: entityDelegate.getEntityHost()) as! ASProtection
        
        protection.receiveDamage(receiveDamageAction: self)
        
        entityDelegate.getEntityHost().endAction(action: self)
    }
    
    func addDamage(damageType: DamageTypeASW, strength: Double)
    {
        let newDamageTuple = (damageType: damageType, strength: strength)
        
        damages.append(newDamageTuple)
    }
}
