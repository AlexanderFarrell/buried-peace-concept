//
//  DamageLabelsUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 12/6/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol DamageUISetDelegate {
    func removeDamageLabel(damageLabelView: DamageLabelView)
}

class DamageLabelsUISet: UISet, DamageUISetDelegate {
    
    var labels = Set<DamageLabelView>()
    
    let timeToDisplayLabel = 1.0
    let timeToFadeLabelOut = 0.3
    
    let heightOfLabels = 12.0
    let widthOfLabels = 100.0
    //TODO: Make it fade out only after a while
    
    var meleeDamageIcon: UIImage
    var projectileDamageIcon: UIImage
    var energyDamageIcon: UIImage
    var shockDamageIcon: UIImage
    var corrosiveDamageIcon: UIImage
    var pyroDamageIcon: UIImage
    var disruptionDamageIcon: UIImage
    var psychoDamageIcon: UIImage
    var cyberDamageIcon: UIImage
    var bioDamageIcon: UIImage
    var radioactiveDamageIcon: UIImage
    
    override init(parent: UIViewController) {
        
        //TODO Assets: Add image icons for all the different types of damage
        /*
        meleeDamageIcon = UIImage.init(named: "MeleeDamageIcon")!
        projectileDamageIcon = UIImage.init(named: "ProjectileDamageIcon")!
        energyDamageIcon = UIImage.init(named: "EnergyDamageIcon")!
        shockDamageIcon = UIImage.init(named: "ShockDamageIcon")!
        corrosiveDamageIcon = UIImage.init(named: "CorrosiveDamageIcon")!
        pyroDamageIcon = UIImage.init(named: "PyroDamageIcon")!
        disruptionDamageIcon = UIImage.init(named: "DisruptionDamageIcon")!
        psychoDamageIcon = UIImage.init(named: "PsychoDamageIcon")!
        cyberDamageIcon = UIImage.init(named: "CyberDamageIcon")!
        bioDamageIcon = UIImage.init(named: "BioDamageIcon")!
        radioactiveDamageIcon = UIImage.init(named: "RadioactiveDamageIcon")!
        */
        
        let clayImagePlaceholder = ClayImage.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let imagePlaceholder = clayImagePlaceholder.getUIImage8BitColor()
        
        meleeDamageIcon = imagePlaceholder
        projectileDamageIcon = imagePlaceholder
        energyDamageIcon = imagePlaceholder
        shockDamageIcon = imagePlaceholder
        corrosiveDamageIcon = imagePlaceholder
        pyroDamageIcon = imagePlaceholder
        disruptionDamageIcon = imagePlaceholder
        psychoDamageIcon = imagePlaceholder
        cyberDamageIcon = imagePlaceholder
        bioDamageIcon = imagePlaceholder
        radioactiveDamageIcon = imagePlaceholder
        
        super.init(parent: parent)
    }
    
    func displayDamageInfoLabel(x: Double, y: Double, typeOfDamage: DamageTypeASW, message: String)
    {
        //TODO: Display Damage Info (This helps us to do things like "Stunned", or "Disabled", or "Weakened")
    }
    
    func displayDamageLabel(x: Double, y: Double, typeOfDamage: DamageTypeASW, amo: Double)
    {
        //TODO: Add damage multiplier indicators
        //... indicates the damage is not really working
        //! indicates the damage is working. We get another ! mark for each 0.5x the damage multiplier is at? Or 0.33?
        
        let xCG = CGFloat(x - (widthOfLabels/2.0))
        let yCG = CGFloat(y - (heightOfLabels/2.0))
        
        var iconToDisplay: UIImage
        var text: NSAttributedString
        
        switch typeOfDamage {
        case .Bio:
            iconToDisplay = bioDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamageBioColor, shadowColor: UIColor.black)
            break
        case .Corrosion:
            iconToDisplay = corrosiveDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamageCorrosiveColor, shadowColor: UIColor.black)
            break
        case .Cyber:
            iconToDisplay = cyberDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamageCyberColor, shadowColor: UIColor.black)
            break
        case .Disruption:
            iconToDisplay = disruptionDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamageDisruptionColor, shadowColor: UIColor.black)
            break
        case .Energy:
            iconToDisplay = energyDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamageEnergyColor, shadowColor: UIColor.black)
            break
        case .Melee:
            iconToDisplay = meleeDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamageMeleeColor, shadowColor: UIColor.black)
            break
        case .Projectile:
            iconToDisplay = projectileDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamageProjectileColor, shadowColor: UIColor.black)
            break
        case .Psycho:
            iconToDisplay = psychoDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamagePsychoColor, shadowColor: UIColor.black)
            break
        case .Pyro:
            iconToDisplay = pyroDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamagePyroColor, shadowColor: UIColor.black)
            break
        case .Shock:
            iconToDisplay = shockDamageIcon
            text = UISet.getShadowedAttributedString(string: String(Int(round(amo))), textColor: Constants.DamageShockColor, shadowColor: UIColor.black)
            break
        }
        
        let damageLabel = DamageLabelView.init(frame: CGRect.init(x: xCG, y: yCG, width: CGFloat(widthOfLabels), height: CGFloat(heightOfLabels)), image: iconToDisplay, attributedText: text, delegateIn: self)
        
        self.addDamageLabel(damageLabelView: damageLabel)
    }
    
    func addDamageLabel(damageLabelView: DamageLabelView)
    {
        parentViewController.view.addSubview(damageLabelView)
        
        labels.insert(damageLabelView)
        
        UIView.animate(withDuration: timeToDisplayLabel, animations: {
                damageLabelView.alpha = 0.0
                damageLabelView.transform = CGAffineTransform.init(translationX: CGFloat(0.0), y: CGFloat(-100.0))
            }, completion: { (true) in
                self.removeDamageLabel(damageLabelView: damageLabelView)
        })
    }
    
    func removeDamageLabel(damageLabelView: DamageLabelView) {
        damageLabelView.breakdown()
        
        labels.remove(damageLabelView)
    }
}
