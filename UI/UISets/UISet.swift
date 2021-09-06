//
//  UISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class UISet: GameplayObject {
    var parentViewController: UIViewController
    var isActive: Bool = false
    var views = [UIView]()
    var childUISets = [UISet]()
    
    init(parent: UIViewController) {
        parentViewController = parent
    }
    
    func placeUI()
    {
        var iSet = 0
        
        while iSet < childUISets.count
        {
            childUISets[iSet].placeUI()
            
            iSet += 1
        }
    }
    
    func refreshUILocations()
    {
        var iSet = 0
        
        while iSet < childUISets.count
        {
            childUISets[iSet].refreshUILocations()
            
            iSet += 1
        }
    }
    
    func addView(view: UIView)
    {
        views.append(view)
        
        parentViewController.view.addSubview(view)
    }
    
    func hideUI(hideChildren: Bool)
    {
        var iView = 0
        
        while iView < views.count
        {
            views[iView].isHidden = true
            
            iView += 1
        }
        
        if hideChildren
        {
            var iSet = 0
            
            while iSet < childUISets.count
            {
                childUISets[iSet].hideUI(hideChildren: true)
                
                iSet += 1
            }
        }
    }
    
    func showUI(showChildren: Bool)
    {
        var iView = 0
        
        while iView < views.count
        {
            views[iView].isHidden = false
            
            iView += 1
        }
        
        if showChildren
        {
            var iSet = 0
            
            while iSet < childUISets.count
            {
                childUISets[iSet].showUI(showChildren: true)
                
                iSet += 1
            }
        }
    }
    
    func enableUI(enableChildren: Bool)
    {
        var iView = 0
        
        while iView < views.count
        {
            views[iView].isUserInteractionEnabled = true
            
            iView += 1
        }
        
        if enableChildren
        {
            var iSet = 0
            
            while iSet < childUISets.count
            {
                childUISets[iSet].enableUI(enableChildren: true)
                
                iSet += 1
            }
        }
    }
    
    func disableUI(disableChildren: Bool)
    {
        var iView = 0
        
        while iView < views.count
        {
            views[iView].isUserInteractionEnabled = false
            
            iView += 1
        }
        
        if disableChildren
        {
            var iSet = 0
            
            while iSet < childUISets.count
            {
                childUISets[iSet].disableUI(disableChildren: true)
                
                iSet += 1
            }
        }
    }
    
    func addChildUISet(child: UISet)
    {
        childUISets.append(child)
        child.gameplayDelegate = self
    }
    
    func breakdownUI()
    {
        var iSet = 0
        
        while iSet < childUISets.count
        {
            childUISets[iSet].breakdownUI()
            
            iSet += 1
        }
        
        while views.count > 0
        {
            views[0].isHidden = true
            views[0].isUserInteractionEnabled = false
            
            //views[0].removeFromSuperview()
            views.removeFirst()
        }
    }
    
    class func getShadowedAttributedString(string: String, textColor: UIColor, shadowColor: UIColor, shadowBlurRadius: CGFloat = CGFloat(2.0), shadowOffset: CGSize = CGSize.init(width: 3, height: 3)) -> NSAttributedString
    {
        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = shadowBlurRadius
        myShadow.shadowOffset = shadowOffset
        myShadow.shadowColor = shadowColor
        
        let retValAttributedString = NSAttributedString.init(string: string, attributes: [NSAttributedStringKey.shadow: myShadow, NSAttributedStringKey.foregroundColor: textColor])
        
        return retValAttributedString
    }
}
