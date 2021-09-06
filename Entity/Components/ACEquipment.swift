//
//  ACEquipment.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/10/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ACEquipment: AgentComponent, ACTargeterListener {
    
    var weaponsActive = [Weapon]()
    
    func updateTarget(target: Entity, interactions: Set<InteractionTypesEntity>?) {
        if interactions != nil
        {
            for interaction in interactions!
            {
                if interaction == .Combat
                {
                    let targeter = (ACTargeter.GetComponent(entity: self.entityDelegate.getEntityHost()) as! ACTargeter)
                    
                    for weapon in weaponsActive
                    {
                        for attack in weapon.attacks
                        {
                            if attack.isRecursive
                            {
                                let attackAutoInteraction = AAActiveAttack.init(interactionTypeIn: .Combat)
                                attackAutoInteraction.target = target
                                attackAutoInteraction.weapon = weapon
                                attackAutoInteraction.verbName = attack.name
                                attackAutoInteraction.attack = attack
                                attackAutoInteraction.assetIdentifier = weapon.name + attack.name
                                targeter.currentInteractions!.append(attackAutoInteraction)
                            }
                            else
                            {
                                let attackInteraction = AAAttack.init(interactionTypeIn: .Combat)
                                attackInteraction.target = target
                                attackInteraction.verbName = attack.name
                                attackInteraction.attack = attack
                                attackInteraction.assetIdentifier = weapon.name + attack.name
                                targeter.currentInteractions!.append(attackInteraction)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func targetHasCleared() {
        
    }
    
    override func begin() {
        let targeter = (ACTargeter.GetComponent(entity: self.entityDelegate.getEntityHost()) as! ACTargeter)
        
        targeter.addSubscriber(subscriber: self)
        
        super.setup()
    }
    
    override class func componentName() -> String{
        return "Equipment"
    }
}
