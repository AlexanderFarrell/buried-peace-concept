//
//  AATravelToTile.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/6/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AATravelToTile: AAInteraction {
    let distanceToTravel: Float = 10.0
    
    override init(interactionTypeIn: InteractionTypesEntity) {
        super.init(interactionTypeIn: interactionTypeIn)
        
        self.verbName = "Travel"
        self.progressiveName = "Traveling"
    }
    
    override func begin() {
        
        let host = self.entityDelegate.getEntityHost()
        
        if (distanceToTravel > TDVector3Distance(host.Position(), target!.Position()))
        {
            let underground = getUnderground()
            
            var travelString = ""
            
            var displayLayerString: String? = nil
            
            let microWorld = getMicroWorld()
            
            microWorld.cleanupPreviousTileBeforeTransition()
            
            if target! is PathwayToTile
            {
                switch (target! as! PathwayToTile).direction {
                case 0:
                    underground.playerLocationX -= 1
                    microWorld.playerStartDirection = 1
                    travelString = "west"
                    break
                case 1:
                    underground.playerLocationX += 1
                    microWorld.playerStartDirection = 0
                    travelString = "east"
                    break
                case 2:
                    underground.playerLocationY -= 1
                    microWorld.playerStartDirection = 3
                    travelString = "north"
                    break
                case 3:
                    underground.playerLocationY += 1
                    microWorld.playerStartDirection = 2
                    travelString = "south"
                    break
                default:
                    underground.playerLocationY += 1
                    microWorld.playerStartDirection = 4
                    travelString = "south"
                    break
                }
            }
            
            if target! is Trapdoor
            {
                underground.playerLocationLayer += 1
                microWorld.playerStartDirection = 2
                travelString = "to the layer below"
                displayLayerString = "You are now in layer " + String(underground.playerLocationLayer) + " in the underground."
                
                getCave().texturePalette.reload()
            }
            
            if target! is Ladder
            {
                underground.playerLocationLayer -= 1
                microWorld.playerStartDirection = 2
                travelString = "to the layer above"
                displayLayerString = "You are now in layer " + String(underground.playerLocationLayer) + " in the underground."
                
                getCave().texturePalette.reload()
            }
            
            if !underground.hasTile(x: underground.playerLocationX, y: underground.playerLocationY, layer: underground.playerLocationLayer)
            {
                underground.generateTile(x: underground.playerLocationX, y: underground.playerLocationY, layer: underground.playerLocationLayer)
            }
            
            microWorld.relayoutTile = true
            
            displayMessage(message: "You travel " + travelString + " in the underground.")
            
            if displayLayerString != nil
            {
                displayMessage(message: displayLayerString!)
            }
            
            let targeter = (ACTargeter.GetComponent(entity: self.entityDelegate.getEntityHost()) as! ACTargeter)
            targeter.clearTarget()
        }
        else
        {
            displayMessage(message: "You need to get closer to the " + target!.name + " to " + self.verbName.lowercased() + ".")
        }
        
        self.entityDelegate.getEntityHost().endAction(action: self)
    }
}
