//
//  ActionSelectorUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ActionSelectorUISet: UISet, ACTargeterInteractionsListListener {
    
    //UI
    var targetNameLabel: UILabel!
    var actionButtons = [UIButton]()
    
    //UI Constants
    let buttonWidth = 200.0
    let buttonRightBorder = 20.0
    let buttonHeight = 40.0
    let buttonSpacing = 5.0
    let yStart = 200.0
    
    override func placeUI()
    {
        setupTargetLabel()
        
        super.placeUI()
    }
    
    func setupTargetLabel()
    {
        let xStart = Double(parentViewController.view.bounds.width) - buttonRightBorder - buttonWidth
        let y = yStart - 40.0
        
        targetNameLabel = UILabel.init(frame: CGRect.init(x: xStart, y: y, width: buttonWidth, height: buttonHeight))
        targetNameLabel.textColor = Constants.NormalUIColor
        targetNameLabel.font = UIFont.systemFont(ofSize: CGFloat(20.0))
        
        //Subscribe
        
        let targeter = (ACTargeter.GetComponent(entity: self.gameplayDelegate.getEntityEngine().player) as! ACTargeter)
        
        targeter.addSubscriberInteractionList(subscriber: self)
        
        addView(view: targetNameLabel)
    }
    
    func setActionButtons(strings: [String], indices: [Int], targetName: String) {
        
        targetNameLabel.attributedText = UISet.getShadowedAttributedString(string: targetName.capitalized, textColor: Constants.NormalUIColor, shadowColor: Constants.ShadowUIColor)//text = targetName.capitalized
        
        if actionButtons.count > 0
        {
            deleteButtons()
        }
        
        populateButtons(interactions: strings, indices: indices)
        
    }
    
    func clearActionButtons() {
        targetNameLabel.text = ""
        
        deleteButtons()
    }
    
    func deleteButtons()
    {
        for button in actionButtons
        {
            button.isHidden = true
            
            button.removeFromSuperview()
        }
        
        actionButtons.removeAll()
        
    }
    
    func populateButtons(interactions: [String], indices: [Int])
    {
        let buttonCount = interactions.count
        
        var iButton = 0
        
        let xStart = Double(parentViewController.view.bounds.width) - buttonRightBorder - buttonWidth
        
        while iButton < buttonCount
        {
            let spacing = buttonSpacing * Double(iButton)
            let yHeight = buttonHeight * Double(iButton)
            let y = spacing + yHeight + yStart
            
            let button = UIButton.init(frame: CGRect.init(x: xStart, y: y, width: buttonWidth, height: buttonHeight))
            button.setTitle(interactions[iButton], for: .normal)
            button.backgroundColor = UIColor.init(red: CGFloat(0.0), green: CGFloat(0.4), blue: CGFloat(0.5), alpha: CGFloat(0.4))
            button.setTitleColor(Constants.NormalUIColor, for: .normal)
            button.tag = indices[iButton]
            button.addTarget(self, action: #selector(actionButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
            
            actionButtons.append(button)
            
            parentViewController.view.addSubview(button)
            addView(view: button)
            
            iButton += 1
        }
    }
    
    @objc func actionButtonPressed(sender: UIButton)
    {
        self.getEntityEngine().player.startAction(actionIndex: sender.tag)
        
        sender.backgroundColor = Constants.ActiveUIColor
        sender.setTitleColor(Constants.ActiveUIColor, for: .normal)
        
        UIView.animate(withDuration: 0.1, animations: {
            sender.backgroundColor = UIColor.init(red: CGFloat(0.0), green: CGFloat(0.4), blue: CGFloat(0.5), alpha: CGFloat(0.4))
            sender.setTitleColor(Constants.NormalUIColor, for: .normal)
        })
    }
    
    override func refreshUILocations()
    {
        super.refreshUILocations()
    }
    
    override func breakdownUI()
    {
        let player = gameplayDelegate.getMicroWorld().entityEngine.player
        let targeter = ACTargeter.GetComponent(entity: player!) as! ACTargeter
        targeter.removeSubscriberInteractionList(subscriber: self)
        
        deleteButtons()
        
        targetNameLabel.removeFromSuperview()
        
        super.breakdownUI()
        
        for view in self.views
        {
            view.removeFromSuperview()
        }
        
        self.views.removeAll()
    }
    
    override func hideUI(hideChildren: Bool) {
        clearActionButtons()
        
        super.hideUI(hideChildren: hideChildren)
    }
    
    func updateTargetIL(target: Entity, interactions: [AAInteraction]?) {
        
        
        var strings = [String]()
        var indices = [Int]()
        
        if interactions != nil
        {
            var iInteraction = 0
            
            while iInteraction < interactions!.count
            {
                //strings.append("" + target.name)
                strings.append(interactions![iInteraction].verbName.capitalized)
                indices.append(iInteraction)
                
                iInteraction += 1
            }
        }
        
        setActionButtons(strings: strings, indices: indices, targetName: target.name)
    }
    
    func targetHasClearedIL() {
        clearActionButtons()
    }
    
    /*var targetNameLabel: UILabel!
    
    var actionButtons = [UIButton]()
    
    let buttonWidth = 200.0
    let buttonRightBorder = 20.0
    let buttonHeight = 40.0
    let buttonSpacing = 5.0
    let yStart = 200.0
    
    override init(parent: UIViewController) {
        super.init(parent: parent)
    }
    
    override func placeUI()
    {
        setupTargetLabel()
        
        super.placeUI()
    }
    
    func setupTargetLabel()
    {
        let xStart = Double(parentViewController.view.bounds.width) - buttonRightBorder - buttonWidth
        let y = yStart - 40.0
        
        targetNameLabel = UILabel.init(frame: CGRect.init(x: xStart, y: y, width: buttonWidth, height: buttonHeight))
        targetNameLabel.textColor = Constants.NormalUIColor
        targetNameLabel.font = UIFont.systemFont(ofSize: CGFloat(20.0))
        
        addView(view: targetNameLabel)
    }
    
    override func setActionButtons(strings: [String], indices: [Int], targetName: String) {
        
        targetNameLabel.text = targetName.capitalized
        
        if actionButtons.count > 0
        {
            deleteButtons()
        }
        
        populateButtons(interactions: strings, indices: indices)
    }
    
    override func clearActionButtons() {
        targetNameLabel.text = ""
        
        deleteButtons()
    }
    
    func deleteButtons()
    {
        for button in actionButtons
        {
            button.isHidden = true
            
            button.removeFromSuperview()
        }
        
        actionButtons.removeAll()
    }
    
    func populateButtons(interactions: [String], indices: [Int])
    {
        let buttonCount = interactions.count
        
        var iButton = 0
        
        let xStart = Double(parentViewController.view.bounds.width) - buttonRightBorder - buttonWidth
        
        while iButton < buttonCount
        {
            let spacing = buttonSpacing * Double(iButton)
            let yHeight = buttonHeight * Double(iButton)
            let y = spacing + yHeight + yStart
            
            let button = UIButton.init(frame: CGRect.init(x: xStart, y: y, width: buttonWidth, height: buttonHeight))
            button.setTitle(interactions[iButton], for: .normal)
            button.backgroundColor = UIColor.init(red: CGFloat(0.0), green: CGFloat(0.8), blue: CGFloat(1.0), alpha: CGFloat(0.2))
            button.setTitleColor(Constants.NormalUIColor, for: .normal)
            button.tag = indices[iButton]
            button.addTarget(self, action: #selector(actionButtonPressed(sender:)), for: UIControlEvents.touchUpInside)
            
            actionButtons.append(button)
            
            parentViewController.view.addSubview(button)
            
            iButton += 1
        }
    }
    
    @objc func actionButtonPressed(sender: UIButton)
    {
        self.getEntityEngine().respondToActionButton(button: sender.tag)
    }
    
    override func refreshUILocations()
    {
        super.refreshUILocations()
    }
    
    override func breakdownUI()
    {
        super.breakdownUI()
        
        deleteButtons()
        
        targetNameLabel.removeFromSuperview()
    }
    */
}
