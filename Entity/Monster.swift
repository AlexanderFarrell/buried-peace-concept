//
//  Monster.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/8/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Monster: DrawableEntity {
    var meleeAI: AABasicMeleeAI!
    var tier: Double = 1.0
    var level: Int = 1
    var equipment: ACEquipment?
    var targeter: ACTargeter?
        
    override func setup() {
        setupMesh()
        setupTexture()
        setupTestAI()//"Monster"
        
        //let minLevel = Underground.getMinLevelForLayer(layer: currentLayer)
        //let maxLevel = Underground.getMaxLevelForLayer(layer: currentLayer)

        self.level = 1//getRandomMicro().nextIntInRange(minValue: minLevel, maxValue: maxLevel+1)
        
        tier = Double(getRandomMicro().nextFloatMaxValue(maxValue: 1.0)) + 0.5
        tier *= Weapon.getMultiplierWithLevel(level: self.level)
        
        let health = ceil(50.0 * tier)
        
        let protection = ASProtection()
        protection.MaxHealth = health
        protection.Health = health
        protection.DeleteOnDeath = false
        
        let deathAction = AAMonsterDie()
        deathAction.drop = getRandomDrop()
        protection.actionOnDeath = deathAction
        
        self.beginState(state: protection)
        
        let tapResponder = ACTapResponder()
        self.beginComponent(component: tapResponder)
        
        self.validatePhysics = true
        
        self.name = self.name + " - Lvl "  + String(level)
        
        super.setup()
    }
    
    func getRandomDrop() -> InventoryItem?
    {
        var retVal: InventoryItem? = nil
        
        if getRandomMicro().nextIntMaxValue(maxValue: 4) == 0
        {
            let weapon: Weapon = Weapon.getRandomWeapon(random: getRandomMicro())
            weapon.level = level
            weapon.rarity = 0
            
            if getRandomMicro().nextIntMaxValue(maxValue: 10) == 0
            {
                weapon.rarity = 1
                
                if getRandomMicro().nextIntMaxValue(maxValue: 10) == 0
                {
                    weapon.rarity = 2
                }
            }
            //Turn into while loop, with an escape at 5 or 10. Perhaps make more rarity intervals, which mean less. Like particular.
            
            Weapon.applyDamageMultiplier(weapon: weapon)
            
            weapon.registerProjectiles(projectileAssetManager: getEntityEngine().projectileAssetManager, renderer: getRenderer())
            
            let itemType = InventoryItemType.init(weaponIn: weapon)
            let item = InventoryItem.init(typeIn: itemType)
            item.quantity = 1
            
            getMacroWorld().inventoryManager.addInventoryType(typeInv: itemType, identifier: weapon.name)
            //(ACInventory.GetComponent(entity: self) as! ACInventory).contents.append(item)
            
            retVal = item
            
            print(item.typeInv.name)
        }
        
        return retVal
    }
    
    /*
     let gernade = Weapon()
     gernade.name = "Gernade"
     gernade.sound = "Explosion"
     gernade.descriptionIIT = "Good situational area offense."
     gernade.attacks.append(Attack.init(damageTypeIn: .Shock, strengthIn: 100.0, nameIn: "Gernade"))
     arsenal.append(gernade)
     
     let laser = Weapon()
     laser.name = "Laser"
     laser.descriptionIIT = "Standard single target offense."
     laser.sound = "Laser002"
     laser.attacks.append(Attack.init(damageTypeIn: .Energy, strengthIn: 35.0, nameIn: "Laser Shot"))
     laser.attacks.append(Attack.init(damageTypeIn: .Disruption, strengthIn: 5.0, nameIn: "Stun Pulse"))
     arsenal.append(laser)
     
     let laserPistol = Weapon()
     laserPistol.name = "Laser Pistol"
     laserPistol.descriptionIIT = "Consistent single target offense."
     laserPistol.attacks.append(Attack.init(damageTypeIn: .Energy, strengthIn: 20.0, nameIn: "Laser Pistol Shot"))
     arsenal.append(laserPistol)
     
     let rifle = Weapon()
     rifle.name = "Rifle"
     rifle.descriptionIIT = "Standard single target offense."
     rifle.attacks.append(Attack.init(damageTypeIn: .Projectile, strengthIn: 40.0, nameIn: "Rifle Shot"))
     arsenal.append(rifle)
     
     let shotgun = Weapon()
     shotgun.name = "Shotgun"
     shotgun.descriptionIIT = "Very effective in close range."
     shotgun.attacks.append(Attack.init(damageTypeIn: .Projectile, strengthIn: 40.0, nameIn: "Shotgun Shot"))
     arsenal.append(shotgun)
     
     let sniper = Weapon()
     sniper.name = "Sniper"
     sniper.descriptionIIT = "Very effective in long range."
     sniper.attacks.append(Attack.init(damageTypeIn: .Projectile, strengthIn: 100.0, nameIn: "Snipe"))
     arsenal.append(sniper)
     
     let infector = Weapon()
     infector.name = "Infector"
     infector.sound = "Laser002"
     infector.descriptionIIT = "Infect through armor."
     infector.attacks.append(Attack.init(damageTypeIn: .Bio, strengthIn: 20.0, nameIn: "Infect"))
     arsenal.append(infector)
     
     for weapon in arsenal
     {
     let itemType = InventoryItemType.init(weaponIn: weapon)
     let item = InventoryItem.init(typeIn: itemType)
     item.quantity = 1
     
     getMacroWorld().inventoryManager.addInventoryType(typeInv: itemType, identifier: weapon.name)
     (ACInventory.GetComponent(entity: self) as! ACInventory).contents.append(item)
     
     print(item.typeInv.name)
     }
 */
    
    func setupMesh()
    {
        let clayMesh = ClayGeometry.createUVSphere(latitudeLines: 5, longitudeLines: 5, radius: 0.7 * Float(tier))
        clayMesh.translateVertices(translation: TDVector3Make(0.0, 1.5 * Float(tier), 0.0))
        
        mesh = clayMesh.getMeshVertexPosTex(renderer: getRenderer())
    }
    
    func setupTexture()
    {
        let clayImage = ClayImage.init(red: getRandomMicro().nextFloatUnit(), green: getRandomMicro().nextFloatUnit(), blue: getRandomMicro().nextFloatUnit(), alpha: 1.0)
        
        texture = RETexture.init(clayImage: clayImage, renderer: getRenderer(), mipmapped: false)
    }
    
    func setupTestAI()
    {
        /*let randomWalk = AARandomWalk()
        randomWalk.walkSpeed = 0.06
        randomWalk.maxWaitTime = 400
        randomWalk.maxWalkTime = 200
        self.beginAction(action: randomWalk)
        
        walkAction = randomWalk*/
        
        meleeAI = AABasicMeleeAI()
        self.beginAction(action: meleeAI)
    }
    
    override func getInteractions() -> Set<InteractionTypesEntity>? {
        
        var retVal = Set<InteractionTypesEntity>()
        
        retVal.insert(.Combat)
        
        return retVal
    }
}
