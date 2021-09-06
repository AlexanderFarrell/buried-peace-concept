//
//  ASProtection.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum DamageTypeASW {
    case Melee
    case Projectile
    case Energy
    case Shock
    case Corrosion
    case Pyro
    case Disruption
    case Cyber
    case Psycho
    case Bio
}

class ASProtection: AgentState {
    var Health: Double = 1.0
    var MaxHealth: Double = 1.0
    
    //Elementary
    var MeleeResist: Double = 0.0
    var ProjectileResist: Double = 0.0
    var EnergyResist: Double = 0.0
    var ShockResist: Double = 0.0
    
    //Special
    var PyroResist: Double = 0.0
    var CorrosionResist: Double = 0.0
    var DisruptionResist: Double = 0.0
    
    //Independent
    var PsychoResist: Double = 0.0
    var CyberResist: Double = 0.0
    var BioResist: Double = 0.0
    
    var DeleteOnDeath: Bool = false
    
    var actionOnDeath: AgentAction?
    var givenDeathAction = false
    
    func receiveDamage(receiveDamageAction: AAReceiveDamage)
    {
        for damage in receiveDamageAction.damages
        {
            var damageAmount = 0.0
            //let previousHealth = Health
            
            switch damage.damageType
            {
            case .Melee:
                damageAmount = (damage.strength) * (1.0 - MeleeResist)
                break
                
            case .Projectile:
                damageAmount = (damage.strength) * (1.0 - ProjectileResist)
                break
                
            case .Energy:
                damageAmount = (damage.strength) * (1.0 - EnergyResist)
                break
                
            case .Shock:
                damageAmount = (damage.strength) * (1.0 - ShockResist)
                break
                
            case .Pyro:
                damageAmount = (damage.strength) * (1.0 - PyroResist)
                break
                
            case .Corrosion:
                damageAmount = (damage.strength) * (1.0 - CorrosionResist)
                break
                
            case .Disruption:
                damageAmount = (damage.strength) * (1.0 - DisruptionResist)
                break
                
            case .Psycho:
                damageAmount = (damage.strength) * (1.0 - PsychoResist)
                break
                
            case .Cyber:
                damageAmount = (damage.strength) * (1.0 - CyberResist)
                break
                
            case .Bio:
                damageAmount = (damage.strength) * (1.0 - BioResist)
                break
            }
            
            damageAmount = (damageAmount > 0) ? damageAmount : 0
            Health -= damageAmount
            
            let screenPos = entityDelegate.getEntityHost().screenPosition(view: getView())
            displayDamage(xScreen: Double(screenPos.v.0), yScreen: Double(screenPos.v.1), amount: damageAmount, typeOfDamage: damage.damageType)
            
            //print(entityDelegate.getEntityHost().name + " took " + String(damageAmount) + " damage. Health went from " + String(previousHealth) + " to " + String(Health))
        }
        
        
        if Health <= 0
        {
            die()
        }
    }
    
    
    func die()
    {
        if DeleteOnDeath
        {
            entityDelegate.getEntityHost().beginAction(action: AADeleteSelf())
        }
        else
        {
            if (actionOnDeath != nil) && (!givenDeathAction)
            {
                entityDelegate.getEntityHost().beginAction(action: actionOnDeath!)
            }
        }
    }
    
    override class func stateName() -> String
    {
        return "Protection "
    }
}
