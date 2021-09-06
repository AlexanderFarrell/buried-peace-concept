//
//  Player.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/27/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Player: Entity, ACTargeterListener {
    
    var walkTranslationFromUI: CGPoint! = CGPoint.zero
    var turnTranslationFromUI: CGPoint! = CGPoint.zero
    
    let JOYSTICK_RADIUS: CGFloat = 30.0
    let MAXIMUM_WALK_SPEED: CGFloat = 20000.0/60.0/60.0/60.0
    
    override func setup() {
        
        //Protection
        let protection = ASProtection()
        protection.MaxHealth = 500
        protection.Health = 500
        protection.actionOnDeath = AARespawnPlayer()
        protection.givenDeathAction = false
        protection.DeleteOnDeath = false
        
        self.beginState(state: protection)
        
        self.validatePhysics = true
        
        //Targeter
        let targeter = ACTargeter()
        targeter.addSubscriber(subscriber: self)
        self.beginComponent(component: targeter)
        
        let equipment = ACEquipment()
        
        /*let laser = Weapon()
        laser.attacks.append(Attack.init(damageTypeIn: .Energy, strengthIn: 35.0, nameIn: "Laser Shot"))
        laser.attacks.append(Attack.init(damageTypeIn: .Shock, strengthIn: 200.0, nameIn: "Laser Fist"))
        laser.attacks.append(Attack.init(damageTypeIn: .Disruption, strengthIn: 5.0, nameIn: "Stun Pulse"))
        equipment.weaponsActive.append(laser)*/
        self.beginComponent(component: equipment)
        
        let inventory = ACInventory()
        self.beginComponent(component: inventory)
        
        createRandomWeapons()
        
        getSoundEngine().addSound(path: "LaserSound.mp3", soundID: "Laser", kind: .SoundFx)
    }
    
    func layoutTile()
    {
        
    }
    
    func createRandomWeapons()
    {
        var arsenal = [Weapon]()
        
        let start = Weapon()
        start.name = "Makeshift Pistol"
        start.sound = "Laser"
        start.descriptionIIT = "This will keep me alive until I find something stronger."
        start.attacks.append(Attack.init(damageTypeIn: .Shock, strengthIn: 15.0, nameIn: "Shoot"))
        start.registerProjectiles(projectileAssetManager: getEntityEngine().projectileAssetManager, renderer: getRenderer())
        arsenal.append(start)
        (ACEquipment.GetComponent(entity: self) as! ACEquipment).weaponsActive.append(start)
        
        for weapon in arsenal
        {
            let itemType = InventoryItemType.init(weaponIn: weapon)
            let item = InventoryItem.init(typeIn: itemType)
            item.quantity = 1
            
            getMacroWorld().inventoryManager.addInventoryType(typeInv: itemType, identifier: weapon.name)
            (ACInventory.GetComponent(entity: self) as! ACInventory).contents.append(item)
            
            print(item.typeInv.name)
        }
        
        //equipment.weaponsActive.append(laser)
    }
    
    override func update() {
        //Update Walk
        
        //let previousPosition = TDVector3Make(x, y, z)
        
        var xRelativeTranslation = walkTranslationFromUI.x/JOYSTICK_RADIUS
        var yRelativeTranslation = walkTranslationFromUI.y/JOYSTICK_RADIUS
        
        xRelativeTranslation = clampTranslation(value: xRelativeTranslation)
        yRelativeTranslation = clampTranslation(value: yRelativeTranslation) //POTENTIALLY MOVE THIS TO VIEW CONTROLLER
        
        xRelativeTranslation = xRelativeTranslation * CGFloat(MAXIMUM_WALK_SPEED)
        yRelativeTranslation = yRelativeTranslation * CGFloat(MAXIMUM_WALK_SPEED)
        
        let relativeVelocity = TDVector3Make(-(Float)(xRelativeTranslation), 0, -(Float)(yRelativeTranslation))
        
        //let speed = TDVector3Length(relativeVelocity)
        
        //Update Rotation
        yaw = yaw - Float(turnTranslationFromUI.x) / 100.0
        pitch = pitch - Float(turnTranslationFromUI.y) / 100.0
        
        if pitch > 0.85
        {
            pitch = 0.85 // Half pi?
        }
        else if pitch < -1
        {
            pitch = -1 //Half pi?
        }
        
        let yawRotationMatrix = TDMatrix4MakeYRotation(yaw)
        
        //var pitchRotationMatrix = TDMatrix4MakeXRotation(pitch)
        
        let velocity = TDMatrix4MultiplyVector3(yawRotationMatrix, relativeVelocity)
        
        //player.y = player.gameplayDelegate.getMap().altitude.levelAt(x: Double(player.x), y: Double(player.z))
        let futurePosition = TDVector3Add(TDVector3Make(x, y, z), velocity)
        
        x = futurePosition.v.0
        y = futurePosition.v.1
        z = futurePosition.v.2
        
        /*let physics = getPhysics()
        
        if physics.isPositionValid(position: futurePosition, radius: 0.1)
        {
            x = futurePosition.v.0
            y = futurePosition.v.1
            z = futurePosition.v.2
        }*/
        
        /*
        if occupyingFloor != nil
        {
            if occupyingFloor!.quadrilateralBounds.isPointInside(point: MSCPoint2.init(x: Double(x), y: Double(z)))
            {
                x = futurePosition.v.0
                y = futurePosition.v.1
                z = futurePosition.v.2
            }
            else
            {
                let previousFloor = occupyingFloor
                
                occupyingFloor = nil
                
                self.getPhysics().findFloor(entity: self)
                
                if occupyingFloor != nil
                {
                    x = futurePosition.v.0
                    y = futurePosition.v.1
                    z = futurePosition.v.2
                }
                else
                {
                    //getPhysics().getInsideFloor(entity: self, floor: previousFloor!, newPosition: futurePosition)
                    
                    occupyingFloor = previousFloor
                    
                    //Push Back
                }
            }
        }
        else
        {
            self.getPhysics().findFloor(entity: self)
        }*/
        
        
        turnTranslationFromUI = CGPoint.zero
        
        super.update()
    }
    
    func clampTranslation(value: CGFloat) -> CGFloat
    {
        var retVal = value
        
        if value > 1 {
            retVal = 1
        }
        else if value < -1
        {
            retVal = -1
        }
        
        return retVal
    }
    
    func startAction(actionIndex: Int)
    {
        let targeter = (ACTargeter.GetComponent(entity: self) as! ACTargeter)
        let actions = targeter.currentInteractions
        
        if actions != nil
        {
            if (actionIndex > -1) && (actionIndex < actions!.count)
            {
                let interaction = actions![actionIndex]
                
                self.beginAction(action: interaction)
            }
        }
    }
    
    func respondToTapSelection(target: Entity?)
    {
        let targeter = (ACTargeter.GetComponent(entity: self) as! ACTargeter)
        
        if target != nil
        {
            targeter.setTarget(newTarget: target!)
        }
        else
        {
            targeter.clearTarget()
        }
    }
    
    func updateTarget(target: Entity, interactions: Set<InteractionTypesEntity>?) {
        
        if interactions != nil
        {
            for interaction in interactions!
            {
                if interaction == .GetToKnow
                {
                    let targeter = (ACTargeter.GetComponent(entity: self) as! ACTargeter)
                    
                    let askInteraction = AAAskProfession(interactionTypeIn: .GetToKnow)
                    askInteraction.verbName = "What do you do?"
                    askInteraction.target = target
                    targeter.currentInteractions!.append(askInteraction)
                    let historyInteraction = AAAskStory(interactionTypeIn: .GetToKnow)
                    historyInteraction.verbName = "What's your story?"
                    historyInteraction.target = target
                    targeter.currentInteractions!.append(historyInteraction)
                }
                
                if interaction == .Assignment
                {
                    let targeter = (ACTargeter.GetComponent(entity: self) as! ACTargeter)
                    
                    let askInteraction = AABlankInteraction(interactionTypeIn: .GetToKnow)
                    askInteraction.verbName = "Ask to Help"
                    targeter.currentInteractions!.append(askInteraction)
                }
                
                if interaction == .Request
                {
                    let targeter = (ACTargeter.GetComponent(entity: self) as! ACTargeter)
                    
                    let askInteraction = AABlankInteraction(interactionTypeIn: .GetToKnow)
                    askInteraction.verbName = "Persuade"
                    targeter.currentInteractions!.append(askInteraction)
                }
                
                if interaction == .Pickup
                {
                    let targeter = (ACTargeter.GetComponent(entity: self) as! ACTargeter)
                    
                    let pickupAction = AAPickup.init(interactionTypeIn: .Pickup)
                    pickupAction.target = targeter.target!
                    
                    targeter.currentInteractions!.append(pickupAction)
                }
                
                if interaction == .Find
                {
                    let targeter = (ACTargeter.GetComponent(entity: self) as! ACTargeter)
                    
                    let findAction = AAFindSurvivor.init(interactionTypeIn: .Find)
                    findAction.target = targeter.target!
                    
                    targeter.currentInteractions!.append(findAction)
                }
            }
        }
    }
    
    func targetHasCleared() {
        
    }
}
