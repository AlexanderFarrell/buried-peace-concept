//
//  AAPickup.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAPickup: AAInteraction {
    
    override init(interactionTypeIn: InteractionTypesEntity) {
        super.init(interactionTypeIn: interactionTypeIn)
        
        self.verbName = "Pick Up"
        self.progressiveName = "Picking Up"
    }
    
    override func begin() {
        super.begin()
        
        //Maybe make pick up distance a parameter. Maybe some entities can pick up items further.
        if TDVector3Distance(self.entityDelegate.getEntityHost().Position(), self.target!.Position()) < 5.0
        {
            let itemTarget = (self.target! as! ItemEntity)
            
            let inventory = (ACInventory.GetComponent(entity: self.entityDelegate.getEntityHost()) as! ACInventory)
            
            self.getSoundEngine().playSound(soundID: "Pickup001")
            
            inventory.contents.append(itemTarget.item)
            
            itemTarget.beginAction(action: AADeleteSelf())
            
            displayMessage(message: "Picked up " + target!.name.capitalized + ". Added to supplies.")
        }
        else
        {
            if self.entityDelegate.getEntityHost() is Player
            {
                displayMessage(message: "I need to get closer to pick up the " + target!.name.capitalized + ".")
            }
        }
        
        
        
        self.entityDelegate.getEntityHost().endAction(action: self)
    }
}
