//
//  AARespawnPlayer.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/8/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AARespawnPlayer: AgentAction {
    override func begin() {
        
        displayMessage(message: "Everything around you seems to fade into darkness.")
        displayMessage(message: "Suddenly, the darkness illuminates, and you find yourself on the surface.")
        displayMessage(message: "The beautiful blue sky finally comes back to your memory. Gone are the toxic clouds of blood.")
        displayMessage(message: "You restfully stare at the beautiful city before you, and cannot seem to remember any violence.")
        displayMessage(message: "The next moment you slowly regain consciousness. A familiar part of the cave you find youself in comes back to your memory.")
        
        let underground = getUnderground()
        let microWorld = getMicroWorld()
        
        //Reset the player
        let player = entityDelegate.getEntityHost() as! Player
        let protection = (ASProtection.GetState(entity: player) as! ASProtection)
        
        //Remove unsecured items
        let inventory = (ACInventory.GetComponent(entity: player) as! ACInventory)
        
        if inventory.contents.count > 1
        {
            var currentItem = inventory.contents.count - 1
            
            while currentItem > -1
            {
                if !inventory.contents[currentItem].keepOnDeath
                {
                    inventory.contents.remove(at: currentItem)
                }
                
                currentItem -= 1
            }
        }
        
        
        
        protection.Health = protection.MaxHealth
        protection.givenDeathAction = false
    }
}
