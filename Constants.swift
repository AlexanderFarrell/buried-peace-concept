//
//  Constants.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    //Visual
    static let WindowBorderColor = UIColor.init(red: 0.0, green: 0.8, blue: 1.0, alpha: 0.3)
    static let WindowBodyColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.1, alpha: 0.5)
    
    static let NormalUIColor = UIColor.init(red: 0.0, green: 0.8, blue: 1.0, alpha: 1.0)
    static let ActiveUIColor = UIColor.init(red: 1.0, green: 0.5, blue: 0.0, alpha: 1.0)
    static let ActiveBackgroundUIColor = UIColor.init(red: 0.5, green: 0.25, blue: 0.0, alpha: 0.5)
    static let InactiveUIColor = UIColor.init(red: 0.35, green: 0.35, blue: 0.35, alpha: 1.0)
    static let CombatUIColor = UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let DestructiveUIColor = UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let PositiveUIColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    static let NegativeUIColor = UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    static let ShadowUIColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.85)
    
    static let DamageMeleeColor = UIColor.init(hue: 0.0, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    static let DamageProjectileColor = UIColor.init(hue: 0.1, saturation: 0.4, brightness: 0.8, alpha: 1.0)
    static let DamageEnergyColor = UIColor.init(hue: 0.5, saturation: 0.4, brightness: 0.8, alpha: 1.0)
    static let DamageShockColor = UIColor.init(hue: 0.25, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    static let DamageCorrosiveColor = UIColor.init(hue: 0.4, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    static let DamagePyroColor = UIColor.init(hue: 0.15, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    static let DamageDisruptionColor = UIColor.init(hue: 0.9, saturation: 0.3, brightness: 0.7, alpha: 1.0)
    static let DamagePsychoColor = UIColor.init(hue: 0.87, saturation: 0.5, brightness: 1.0, alpha: 1.0)
    static let DamageCyberColor = UIColor.init(hue: 0.68, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    static let DamageBioColor = UIColor.init(hue: 0.37, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    static let DamageRadioactiveColor = UIColor.init(hue: 0.82, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    
    static let topRibbonWindowHeight = 50.0
    static let minimumWPWindowWidth = 60.0
    static let wpWindowBorderSize = 5.0
    static let ModalWindowDefaultScreenBorderSizePer = 0.08
    
    static let CameraFieldOfViewDefaultInDegrees = 80.0
    
    //Audio
    
    //Gameplay
    
    //Cave
    static let CaveBufferRadius = 90.0
    static let CaveDebufferRadius = 120.0
    static let CaveSegmentSize = 30.0
    static let EditorCaveBufferRadius = 80.0
    static let EditorCaveDebufferRadius = 100.0
    static let EditorCaveSegmentSize = 15.0
    static let squareSize = 2.0
    
    //Entity
    static let maxRenderDistance = 100.0
    
    //Physics
    
    //Underground
    
    //Serialize
    
    //Engines
    
    //Resources
    
    //Technical
    static let maxValue16Bits = ClayRandom.maxValueForBits(bitCount: 16)
    static let maxValue32Bits = ClayRandom.maxValueForBits(bitCount: 32)
    static let maxValue64Bits = ClayRandom.maxValueForBits(bitCount: 64)
    
    static func addStandardShadowUIElements(view: UIView, color: UIColor, opacity: Float = 0.3, offset: CGSize, radius: CGFloat = 1, scale: Bool = true)
    {
        view.layer.masksToBounds = false
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
