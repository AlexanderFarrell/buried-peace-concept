//
//  InventoryItem.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class InventoryItem: GameplayObject {
    var typeInv: InventoryItemType
    var quantity: Int = 0
    var keepOnDeath = false
    
    init(typeIn: InventoryItemType) {
        typeInv = typeIn
    }
    
    func getLongDescriptionOfItem() -> String
    {
        var retValString = typeInv.descriptionIIT + "\n" + "\n"
        
        if keepOnDeath
        {
            retValString = retValString + "This item will be kept upon death."
        }
        else
        {
            if typeInv.securableOnDeath
            {
                retValString = retValString + "This item was recently acquired and WILL BE LOST ON DEATH. Visit a human settlement to secure it."
            }
            else
            {
                retValString = retValString + "This item WILL BE LOST ON DEATH, and cannot be secured."
            }
        }
        
        if typeInv.weapon != nil
        {
            let weaponRef = typeInv.weapon!
            
            retValString = retValString + "\n" + "Level: " + String(weaponRef.level)
            retValString = retValString + "\n" + "Rarity: " + String(weaponRef.rarity)
            
            retValString = retValString + "\n" + "\n" + "This weapon has the following attacks:"
            
            for attack in weaponRef.attacks
            {
                retValString = retValString + "\n" + "\n" + attack.name
                retValString = retValString + "\n" + " - Type: " + Attack.DamageTypeToString(damageType: attack.damageType)
                retValString = retValString + "\n" + " - Strength: " + String(attack.strength)
                retValString = retValString + "\n" + " - Min Distance: " + String(attack.minimumDistance)
                retValString = retValString + "\n" + " - Max Distance: " + String(attack.maximumDistance)
                retValString = retValString + "\n" + " - " + attack.name.capitalized + " per Second: " + String(60.0 / Float(attack.cooldown))
                
                if attack.aoeEffect
                {
                    retValString = retValString + "\n" + " - Damage Radius: " + String(attack.aoeRadius) + " meters"
                }
            }
        }
        
        return retValString //Attribute this string!
    }
}
