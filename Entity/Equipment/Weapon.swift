//
//  Weapon.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/10/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

struct Attack {
    var damageType: DamageTypeASW
    var strength: Double
    var name: String
    
    var playSoundWhenFired: Bool = false //Depreciated
    var playSoundWhenHit: Bool = false //Depreciated
    var soundWhenFired: String? = ""
    var soundWhenHit: String? = ""
    
    var projectileRadius: Float = 0.1
    var projectileRed: Float = 0.2
    var projectileGreen: Float = 0.2
    var projectileBlue: Float = 0.2
    var projectileTime: Int = 5
    var projectileStayAfter: Int = 5
    var projectileTrajectory: Float = 0.0
    
    var aoeEffect: Bool = false
    var aoeRadius: Float = 1.0
    
    var cooldown: Int = 12
    var timeLeftToAttack: Int = 12
    
    var isRecursive: Bool = false
    
    var minimumDistance: Double = 0.0
    var maximumDistance: Double = 100.0
    
    //Min Consistency - the minimum damage that a base hit will hit. Some weapons may hit really high, but have less consistency.
    
    //Ideal distance accuracy min
    //Ideal distance accuracy max
    //Ideal distance damage min
    //Ideal distance damage max
    
    //Multi shot
    //Bounce to Target Count
    //Bounce to Target damage reduction
    //Blast Radius
    //Fades damage //(if false, full damage is experienced in radius)
    
    //Power shot
    //Breaks armor
    
    //Time
    //DamageTime enum
    // - single - one execution
    // - stream - continuous execution needed, locks weapon (or attack generally)
    // - independent stream
    
    //Cooldown
    //Cooldown time
    
    //Can target body parts
    
    init(damageTypeIn: DamageTypeASW, strengthIn: Double, nameIn: String) {
        damageType = damageTypeIn          
        strength = strengthIn
        name = nameIn
    }
    
    func registerProjectile(projectileAssetManager: ProjectileAssetManager, renderer: Renderer, additionalString: String)
    {
        projectileAssetManager.registerProjectile(identifier: additionalString + name, mesh: ClayGeometry.createUVSphere(latitudeLines: 7, longitudeLines: 7, radius: projectileRadius).getMeshVertexPosTex(renderer: renderer), texture: RETexture.init(clayImage: ClayImage.init(red: projectileRed, green: projectileGreen, blue: projectileBlue, alpha: 1.0), renderer: renderer, mipmapped: false))
    }
    
    static func DamageTypeToString(damageType: DamageTypeASW) -> String
    {
        switch damageType
        {
        case .Melee:
            return "Melee"
            
        case .Projectile:
            return "Projectile"
            
        case .Energy:
            return "Energy"
            
        case .Shock:
            return "Shock"
            
        case .Pyro:
            return "Pryo"
            
        case .Corrosion:
            return "Corrosion"
            
        case .Disruption:
            return "Disruption"
            
        case .Psycho:
            return "Psycho"
            
        case .Cyber:
            return "Cyber"
            
        case .Bio:
            return "Bio"
        }
    }
}

class Weapon: EquipmentPiece {
    var name: String = "Unknown Weapon"
    var attacks = [Attack]()
    var descriptionIIT: String = "Strange Weapon"
    var sound: String = "Laser"
    var level: Int = 1
    var rarity: Int = 0
    
    var activeRecursiveAttack: AAActiveAttack?
    //var reverseProjectile: Bool
    
    //Texturing
    
    static let WeaponCountNP = 20
    
    func registerProjectiles(projectileAssetManager: ProjectileAssetManager, renderer: Renderer)
    {
        for attack in attacks
        {
            attack.registerProjectile(projectileAssetManager: projectileAssetManager, renderer: renderer, additionalString: name)
        }
    }
    
    class func getWeaponFromList(index: Int) -> Weapon
    {
        let retValWeapon: Weapon = Weapon()
        
        switch index
        {
        case 0:
            retValWeapon.name = "Gernade"
            retValWeapon.sound = "Explosion"
            retValWeapon.descriptionIIT = "Good situational area offense. Use when many enemies are clustering at stressful times."
            var attack1 = Attack.init(damageTypeIn: .Shock, strengthIn: 100.0, nameIn: "Throw Gernade")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 10.0
            attack1.soundWhenFired = "Explosion"
            attack1.projectileTime = 7
            attack1.projectileRed = 0.68
            attack1.projectileGreen = 0.68
            attack1.projectileBlue = 0.68
            attack1.projectileRadius = 0.25
            attack1.projectileTrajectory = 0.2
            attack1.cooldown = 120
            retValWeapon.attacks.append(attack1)
            break
        case 1:
            retValWeapon.name = "Laser"
            retValWeapon.sound = "Laser002"
            retValWeapon.descriptionIIT = "Standard single target offense. Use for normal single target combat."
            var attack1 = Attack.init(damageTypeIn: .Energy, strengthIn: 35.0, nameIn: "Laser Shot")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 35.0
            attack1.projectileTime = 3
            attack1.projectileRed = 0.85
            attack1.projectileGreen = 0.0
            attack1.projectileBlue = 1.0
            attack1.projectileRadius = 0.12
            attack1.projectileTrajectory = 0.0
            attack1.isRecursive = true
            attack1.cooldown = 45
            attack1.soundWhenFired = "Laser002"
            var attack2 = Attack.init(damageTypeIn: .Disruption, strengthIn: 5.0, nameIn: "Stun Pulse")
            attack2.minimumDistance = 0.5
            attack2.maximumDistance = 35.0
            attack2.projectileTime = 2
            attack2.projectileRed = 0.85
            attack2.projectileGreen = 0.85
            attack2.projectileBlue = 1.0
            attack2.projectileRadius = 0.15
            attack2.projectileTrajectory = 0.0
            attack2.cooldown = 120
            attack2.soundWhenFired = "Laser002"
            retValWeapon.attacks.append(attack1)
            retValWeapon.attacks.append(attack2)
            break
        case 2:
            retValWeapon.name = "Laser Pistol"
            retValWeapon.sound = "Laser"
            retValWeapon.descriptionIIT = "Consistent single target offense."
            var attack1 = Attack.init(damageTypeIn: .Energy, strengthIn: 20.0, nameIn: "Laser Pistol Shot")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 20.0
            attack1.projectileTime = 3
            attack1.projectileRed = 0.95
            attack1.projectileGreen = 0.0
            attack1.projectileBlue = 0.85
            attack1.projectileRadius = 0.09
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 30
            attack1.isRecursive = true
            attack1.soundWhenFired = "Laser"
            retValWeapon.attacks.append(attack1)
        case 3:
            retValWeapon.name = "Rifle"
            retValWeapon.sound = "Laser"
            retValWeapon.descriptionIIT = "Standard single target offense."
            var attack1 = Attack.init(damageTypeIn: .Projectile, strengthIn: 40.0, nameIn: "Rifle Shot")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 35.0
            attack1.projectileTime = 3
            attack1.projectileRed = 0.6
            attack1.projectileGreen = 0.6
            attack1.projectileBlue = 0.6
            attack1.projectileRadius = 0.1
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 45
            attack1.isRecursive = true
            attack1.soundWhenFired = "Laser"
            retValWeapon.attacks.append(attack1)
        case 4:
            retValWeapon.name = "Shotgun"
            retValWeapon.sound = "Laser"
            retValWeapon.descriptionIIT = "Very effective in close range."
            var attack1 = Attack.init(damageTypeIn: .Projectile, strengthIn: 40.0, nameIn: "Shotgun Shot")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 15.0
            attack1.projectileTime = 4
            attack1.projectileRed = 0.6
            attack1.projectileGreen = 0.6
            attack1.projectileBlue = 0.6
            attack1.projectileRadius = 0.2
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 50
            attack1.isRecursive = true
            attack1.soundWhenFired = "Laser"
            retValWeapon.attacks.append(attack1)
        case 5:
            retValWeapon.name = "Sniper"
            retValWeapon.sound = "Laser"
            retValWeapon.descriptionIIT = "Very effective in long range."
            var attack1 = Attack.init(damageTypeIn: .Projectile, strengthIn: 100.0, nameIn: "Snipe")
            attack1.minimumDistance = 30.0
            attack1.maximumDistance = 1000.0
            attack1.projectileTime = 4
            attack1.projectileRed = 0.7
            attack1.projectileGreen = 0.7
            attack1.projectileBlue = 0.7
            attack1.projectileRadius = 0.15
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 60
            attack1.isRecursive = true
            attack1.soundWhenFired = "Laser"
            retValWeapon.attacks.append(attack1)
        case 6:
            retValWeapon.name = "Infector"
            retValWeapon.sound = "Laser002"
            retValWeapon.descriptionIIT = "Infect through armor."
            var attack1 = Attack.init(damageTypeIn: .Bio, strengthIn: 20.0, nameIn: "Infect")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 30.0
            attack1.projectileTime = 8
            attack1.projectileRed = 0.3
            attack1.projectileGreen = 0.9
            attack1.projectileBlue = 0.3
            attack1.projectileRadius = 0.3
            attack1.projectileTrajectory = 0.4
            attack1.cooldown = 20
            attack1.isRecursive = true
            attack1.soundWhenFired = "Laser002"
            retValWeapon.attacks.append(attack1)
        case 7:
            retValWeapon.name = "Acid Bombs"
            retValWeapon.sound = "Explosive"
            retValWeapon.descriptionIIT = "Explodes, then corrodes."
            var attack1 = Attack.init(damageTypeIn: .Corrosion, strengthIn: 20.0, nameIn: "Throw Corrosive")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 30.0
            attack1.projectileTime = 7
            attack1.projectileRed = 0.1
            attack1.projectileGreen = 1.0
            attack1.projectileBlue = 0.1
            attack1.projectileRadius = 0.25
            attack1.projectileTrajectory = 0.2
            attack1.cooldown = 120
            attack1.soundWhenFired = "Explosive"
            retValWeapon.attacks.append(attack1)
        case 8:
            retValWeapon.name = "Acid Launcher"
            retValWeapon.sound = "Laser002"
            retValWeapon.descriptionIIT = "Eats through targets armor."
            var attack1 = Attack.init(damageTypeIn: .Corrosion, strengthIn: 20.0, nameIn: "Spray Corrosive")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 15.0
            attack1.projectileTime = 8
            attack1.projectileRed = 0.1
            attack1.projectileGreen = 1.0
            attack1.projectileBlue = 0.1
            attack1.projectileRadius = 0.25
            attack1.projectileTrajectory = 0.12
            attack1.cooldown = 20
            attack1.isRecursive = true
            attack1.soundWhenFired = "Laser002"
            retValWeapon.attacks.append(attack1)
        case 9:
            retValWeapon.name = "Overdriver"
            retValWeapon.sound = "WeaponWield001"
            retValWeapon.descriptionIIT = "Floods systems with information. Use against computers."
            var attack1 = Attack.init(damageTypeIn: .Cyber, strengthIn: 0.0, nameIn: "Brute Force")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 100.0
            attack1.projectileTime = 2
            attack1.projectileRed = 0.0
            attack1.projectileGreen = 0.0
            attack1.projectileBlue = 1.0
            attack1.projectileRadius = 0.05
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 10
            attack1.isRecursive = true
            attack1.soundWhenFired = "WeaponWield001"
            var attack2 = Attack.init(damageTypeIn: .Cyber, strengthIn: 0.0, nameIn: "Clever Attack")
            attack2.minimumDistance = 0.5
            attack2.maximumDistance = 100.0
            attack2.projectileTime = 2
            attack2.projectileRed = 0.0
            attack2.projectileGreen = 0.0
            attack2.projectileBlue = 1.0
            attack2.projectileRadius = 0.05
            attack2.projectileTrajectory = 0.0
            attack2.cooldown = 10
            attack2.isRecursive = true
            attack2.soundWhenFired = "WeaponWield001"
            retValWeapon.attacks.append(attack1)
            retValWeapon.attacks.append(attack2)
        case 10:
            retValWeapon.name = "Screecher"
            retValWeapon.sound = "MonsterSee001"
            var attack1 = Attack.init(damageTypeIn: .Disruption, strengthIn: 10.0, nameIn: "Screech")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 50.0
            attack1.projectileTime = 1
            attack1.projectileRed = 0.0
            attack1.projectileGreen = 0.0
            attack1.projectileBlue = 1.0
            attack1.projectileRadius = 0.0
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 30
            attack1.isRecursive = true
            attack1.soundWhenFired = "MonsterSee001"
            retValWeapon.descriptionIIT = "Creates disturbing radio waves. Effective to stun."
            retValWeapon.attacks.append(attack1)
        case 11:
            retValWeapon.name = "Heavy Rod"
            retValWeapon.sound = "Melee001"
            retValWeapon.descriptionIIT = "Short range rod."
            var attack1 = Attack.init(damageTypeIn: .Melee, strengthIn: 25.0, nameIn: "Thrust")
            attack1.minimumDistance = 0.0
            attack1.maximumDistance = 10.0
            attack1.projectileTime = 1
            attack1.projectileRed = 0.0
            attack1.projectileGreen = 0.0
            attack1.projectileBlue = 1.0
            attack1.projectileRadius = 0.0
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 45
            attack1.isRecursive = true
            attack1.soundWhenFired = "Melee001"
            retValWeapon.attacks.append(attack1)
        case 12:
            retValWeapon.name = "Mask"
            retValWeapon.sound = "WeaponWield002"
            retValWeapon.descriptionIIT = "Scares your enemies."
            var attack1 = Attack.init(damageTypeIn: .Psycho, strengthIn: 20.0, nameIn: "Scare")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 20.0
            attack1.projectileTime = 1
            attack1.projectileRed = 0.0
            attack1.projectileGreen = 0.0
            attack1.projectileBlue = 1.0
            attack1.projectileRadius = 0.0
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 90
            attack1.isRecursive = true
            attack1.soundWhenFired = "WeaponWield002"
            retValWeapon.attacks.append(attack1)
        case 13:
            retValWeapon.name = "Flamethrower"
            retValWeapon.sound = "Laser002"
            retValWeapon.descriptionIIT = "Ignites targets."
            var attack1 = Attack.init(damageTypeIn: .Pyro, strengthIn: 25.0, nameIn: "Ignite")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 20.0
            attack1.projectileTime = 8
            attack1.projectileRed = 1.0
            attack1.projectileGreen = 0.3
            attack1.projectileBlue = 0.0
            attack1.projectileRadius = 0.25
            attack1.projectileTrajectory = 0.12
            attack1.cooldown = 20
            attack1.isRecursive = true
            attack1.soundWhenFired = "Laser002"
            retValWeapon.attacks.append(attack1)
        case 14:
            retValWeapon.name = "Mini-Missile"
            retValWeapon.sound = "Explosion"
            retValWeapon.descriptionIIT = "Small missiles, explode on impact."
            var attack1 = Attack.init(damageTypeIn: .Shock, strengthIn: 25.0, nameIn: "Spray Missiles")
            attack1.minimumDistance = 0.5
            attack1.maximumDistance = 50.0
            attack1.projectileTime = 10
            attack1.projectileRed = 0.7
            attack1.projectileGreen = 0.7
            attack1.projectileBlue = 0.7
            attack1.projectileRadius = 0.25
            attack1.projectileTrajectory = 0.05
            attack1.cooldown = 90
            attack1.isRecursive = true
            attack1.soundWhenFired = "Explosion"
            retValWeapon.attacks.append(attack1)
        case 15:
            retValWeapon.name = "Massive Axe"
            retValWeapon.sound = "Melee001"
            retValWeapon.descriptionIIT = "Not so short range melee axe."
            var attack1 = Attack.init(damageTypeIn: .Melee, strengthIn: 40.0, nameIn: "Thrust")
            attack1.minimumDistance = 0.0
            attack1.maximumDistance = 15.0
            attack1.soundWhenFired = "Melee001"
            attack1.projectileTime = 1
            attack1.projectileRed = 0.0
            attack1.projectileGreen = 0.0
            attack1.projectileBlue = 1.0
            attack1.projectileRadius = 0.0
            attack1.projectileTrajectory = 0.0
            attack1.cooldown = 60
            attack1.isRecursive = true
            retValWeapon.attacks.append(attack1)
        case 16:
            retValWeapon.name = "Makeshift Bow"
            retValWeapon.sound = "Laser"
            retValWeapon.descriptionIIT = "A bow made from scraps of the underground."
            var attack1 = Attack.init(damageTypeIn: .Melee, strengthIn: 20.0, nameIn: "Launch Arrow")
            attack1.minimumDistance = 1.0
            attack1.maximumDistance = 40.0
            attack1.projectileTime = 4
            attack1.projectileRed = 0.7
            attack1.projectileGreen = 0.7
            attack1.projectileBlue = 0.7
            attack1.projectileRadius = 0.12
            attack1.projectileTrajectory = 0.15
            attack1.cooldown = 60
            attack1.isRecursive = true
            attack1.soundWhenFired = "Melee001"
            retValWeapon.attacks.append(attack1)
        case 17:
            retValWeapon.name = "Throwing Stones (Small)"
            retValWeapon.sound = "Melee001"
            retValWeapon.descriptionIIT = "Small stones to throw at monsters. Gives you a better chance at survival until you find something stronger."
            var attack1 = Attack.init(damageTypeIn: .Projectile, strengthIn: 15.0, nameIn: "Throw Stone")
            attack1.minimumDistance = 1.0
            attack1.maximumDistance = 40.0
            attack1.projectileTime = 25
            attack1.projectileRed = 0.5
            attack1.projectileGreen = 0.5
            attack1.projectileBlue = 0.5
            attack1.projectileRadius = 0.15
            attack1.projectileTrajectory = 0.5
            attack1.cooldown = 60
            attack1.isRecursive = true
            attack1.soundWhenFired = "Melee001"
            retValWeapon.attacks.append(attack1)
        case 18:
            retValWeapon.name = "Throwing Stones (Medium)"
            retValWeapon.sound = "Melee001"
            retValWeapon.descriptionIIT = "Medium-szied stones to throw at monsters. Gives you a better chance at survival until you find something stronger."
            var attack1 = Attack.init(damageTypeIn: .Projectile, strengthIn: 22.5, nameIn: "Throw Stone")
            attack1.minimumDistance = 1.0
            attack1.maximumDistance = 32.0
            attack1.soundWhenFired = "Melee001"
            attack1.projectileTime = 28
            attack1.projectileRed = 0.5
            attack1.projectileGreen = 0.5
            attack1.projectileBlue = 0.5
            attack1.projectileRadius = 0.30
            attack1.projectileTrajectory = 0.5
            attack1.cooldown = 75
            attack1.isRecursive = true
            retValWeapon.attacks.append(attack1)
        case 19:
            retValWeapon.name = "Throwing Stones (Large)"
            retValWeapon.sound = "Melee001"
            retValWeapon.descriptionIIT = "Large stones to throw at monsters. Gives you a better chance at survival until you find something stronger."
            var attack1 = Attack.init(damageTypeIn: .Projectile, strengthIn: 30.0, nameIn: "Throw Stone")
            attack1.minimumDistance = 1.0
            attack1.maximumDistance = 24.0
            attack1.projectileTime = 30
            attack1.projectileRed = 0.5
            attack1.projectileGreen = 0.5
            attack1.projectileBlue = 0.5
            attack1.projectileRadius = 0.45
            attack1.projectileTrajectory = 0.5
            attack1.cooldown = 90
            attack1.isRecursive = true
            attack1.soundWhenFired = "Melee001"
            retValWeapon.attacks.append(attack1)
        case 20:
            retValWeapon.name = "Makeshift Pistol"
            retValWeapon.sound = "Melee001"
            retValWeapon.descriptionIIT = "It's pretty lucky to find something like this on the ground, but I still should get something stronger."
            var attack1 = Attack.init(damageTypeIn: .Projectile, strengthIn: 22.5, nameIn: "Shoot")
            attack1.minimumDistance = 1.0
            attack1.maximumDistance = 30.0
            attack1.projectileTime = 3
            attack1.projectileRed = 0.6
            attack1.projectileGreen = 0.6
            attack1.projectileBlue = 0.6
            attack1.projectileRadius = 0.09
            attack1.projectileTrajectory = 0.0
            attack1.isRecursive = true
            attack1.soundWhenFired = "Melee001"
            retValWeapon.attacks.append(attack1)
            
        //WeaponWield002
        default:
            break
        }
        
        return retValWeapon
    }
    
    class func getRandomWeapon(random: ClayRandom) -> Weapon
    {
        let res = random.nextIntMaxValue(maxValue: WeaponCountNP)
        let retValWeapon = Weapon.getWeaponFromList(index: res)
        
        return retValWeapon
    }
    
    class func getRandomBasicWeapon(random: ClayRandom) -> Weapon
    {
        let index = [16, 17, 18, 19]
        
        let retValWeapon = Weapon.getWeaponFromList(index: index[random.nextIntMaxValue(maxValue: index.count)])
        
        return retValWeapon
    }
    
    class func getRandomMeleeWeapon(random: ClayRandom) -> Weapon
    {
        let index = [11, 15]
        
        let retValWeapon = Weapon.getWeaponFromList(index: index[random.nextIntMaxValue(maxValue: index.count)])
        
        return retValWeapon
    }
    
    class func applyDamageMultiplier(weapon: Weapon)
    {
        let multiplier = Weapon.getMultiplierWithLevel(level: weapon.level + weapon.rarity)
        
        var iAttack = 0
        
        while iAttack < weapon.attacks.count
        {
            weapon.attacks[iAttack].strength *= multiplier
            
            iAttack += 1
        }
    }
    
    class func getMultiplierWithLevel(level: Int) -> Double
    {
        let retValMutilplier = pow(1.09, Double(level)) + (Double(level) * 0.12)
        
        return retValMutilplier
    }
}
