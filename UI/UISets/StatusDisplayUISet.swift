//
//  StatusDisplayUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class StatusDisplayUISet: UISet {
    var healthDisplay: UILabel!
    var timer: Timer!
    
    override init(parent: UIViewController) {
        super.init(parent: parent)
    }
    
    override func placeUI()
    {
        setupLabel()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0/12.0, target: self, selector: #selector(refreshLabels), userInfo: nil, repeats: true)
        
        super.placeUI()
        
        showUI(showChildren: true)
    }
    
    func setupLabel()
    {
        healthDisplay = UILabel.init(frame: CGRect.init(x: Double(parentViewController.view.frame.width) - 200.0, y: 5.0, width: 200.0, height: 20.0))
        healthDisplay.textColor = Constants.NormalUIColor
        healthDisplay.font = UIFont.systemFont(ofSize: CGFloat(20.0))
        healthDisplay.textAlignment = NSTextAlignment.right
        
        addView(view: healthDisplay)
    }
    
    @objc func refreshLabels()
    {
        let protection = ASProtection.GetState(entity: self.gameplayDelegate.getEntityEngine().player) as! ASProtection
        
        let healthUnit = protection.Health / protection.MaxHealth
        let healthDecimal = healthUnit * 100.0
        let healthNoDecimal = floor(healthDecimal)
        
        let healthDisplayString = String(healthDecimal - (healthDecimal - healthNoDecimal))
        
        healthDisplay.attributedText = UISet.getShadowedAttributedString(string: "Health: " + healthDisplayString + " %", textColor: Constants.NormalUIColor, shadowColor: Constants.ShadowUIColor, shadowBlurRadius: CGFloat(1.5), shadowOffset: CGSize.init(width: 2, height: 2)) //text = "Health: " + healthDisplayString + " %"
    }
    
    override func refreshUILocations()
    {
        super.refreshUILocations()
    }
    
    override func breakdownUI()
    {
        timer.invalidate()
        timer = nil
        
        super.breakdownUI()
    }
}
