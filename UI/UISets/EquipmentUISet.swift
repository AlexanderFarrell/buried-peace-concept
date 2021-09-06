//
//  EquipmentUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class EquipmentUISet: UISet, EquipmentViewDelegate, BPWindowDelegate {
    
    var bpWindow: BPWindow!
    var gameplayUIDelegate: GameplayUISetDelegate!
    let equipmentItemsDisplayWidthPer = 0.5
    
    //UI
    var itemIconImageView: UIImageView!
    var itemNameLabel: UILabel!
    //var itemDescriptionLabel: UILabel!
    var itemDescriptionTextBox: UITextView!
    var attributesTextView: UITextView!
    
    var activeEquipmentInt: Int = -1
    
    var currentEquipmentList = [InventoryItem]()
    
    override func placeUI()
    {
        let windowBorderSizeX = Double(parentViewController.view.frame.width) * Constants.ModalWindowDefaultScreenBorderSizePer
        let windowBorderSizeY = Double(parentViewController.view.frame.height) * Constants.ModalWindowDefaultScreenBorderSizePer
        
        bpWindow = BPWindow.init(frame: CGRect.init(x: windowBorderSizeX, y: windowBorderSizeY, width: Double(parentViewController.view.frame.width) - (windowBorderSizeX * 2.0), height: Double(parentViewController.view.frame.height) - (windowBorderSizeY * 2.0)), titleIn: "Equipment", delegate: self)
        
        getEquipmentItems(equipmentTag: "Weapon")
        
        setupIcon()
        setupLabels()
        
        addView(view: bpWindow)
        
        let equipmentView = EquipmentView.init(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: bpWindow.bodyFrame.width * CGFloat(equipmentItemsDisplayWidthPer), height: bpWindow.bodyFrame.height))
        equipmentView.equipmentDelegate = self
        
        bpWindow.bodyView.addSubview(equipmentView)
        
        super.placeUI()
    }
    
    
    func setupDescriptionReadout()
    {
        
    }
    
    func getEquipmentItems(equipmentTag: String)
    {
        let inventory = (ACInventory.GetComponent(entity: gameplayDelegate.getEntityEngine().player) as! ACInventory)
        
        currentEquipmentList = [InventoryItem]()
        
        for item in inventory.contents
        {
            for tag in item.typeInv.tags
            {
                if tag == equipmentTag
                {
                    currentEquipmentList.append(item)
                }
            }
        }
    }
    
    func setupIcon()
    {
        let iconPerSize = 0.2
        let iconBorder = 15.0
        let iconSize = Double(bpWindow.bodyFrame.width) * iconPerSize
        let iconX = Double(bpWindow.bodyFrame.width) * ((((1.0 - equipmentItemsDisplayWidthPer) / 2.0) - (iconPerSize/2.0)) + equipmentItemsDisplayWidthPer)
        
        itemIconImageView = UIImageView.init(frame: CGRect.init(x: iconX, y: iconBorder, width: iconSize, height: iconSize))
        itemIconImageView.backgroundColor = UIColor.black
        
        bpWindow.bodyView.addSubview(itemIconImageView)
    }
    
    func setupLabels()
    {
        let labelPerSize = 0.47
        let labelWidth = Double(bpWindow.bodyFrame.width) * labelPerSize
        let xStart = Double(bpWindow.bodyFrame.width) * ((((1.0 - equipmentItemsDisplayWidthPer) / 2.0) - (labelPerSize/2.0)) + equipmentItemsDisplayWidthPer)
        let yName = 40.0 + Double(itemIconImageView.bounds.height)
        let yDescription = 80.0 + Double(itemIconImageView.bounds.height)
        
        itemNameLabel = UILabel.init(frame: CGRect.init(x: xStart, y: yName, width: labelWidth, height: 40.0))
        itemNameLabel.textColor = Constants.NormalUIColor
        itemNameLabel.font = UIFont.systemFont(ofSize: CGFloat(25.0))
        itemNameLabel.textAlignment = NSTextAlignment.center
        
        /*itemDescriptionLabel = UILabel.init(frame: CGRect.init(x: xStart, y: yDescription, width: labelWidth, height: 40.0))
        itemDescriptionLabel.textColor = Constants.NormalUIColor
        itemDescriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(20.0))
        itemDescriptionLabel.textAlignment = NSTextAlignment.center*/
        
        let textContainer = NSTextContainer.init(size: CGSize.init(width: labelWidth, height: Double(bpWindow.bodyFrame.height) - yDescription))
        textContainer.maximumNumberOfLines = 30
        
        itemDescriptionTextBox = UITextView.init(frame: CGRect.init(x: xStart, y: yDescription, width: labelWidth, height: Double(bpWindow.bodyFrame.height) - yDescription), textContainer: nil)
        itemDescriptionTextBox.textColor = Constants.NormalUIColor
        itemDescriptionTextBox.backgroundColor = UIColor.init(white: 1.0, alpha: 0.0)
        itemDescriptionTextBox.isSelectable = false
        itemDescriptionTextBox.isEditable = false
        
        bpWindow.bodyView.addSubview(itemNameLabel)
        bpWindow.bodyView.addSubview(itemDescriptionTextBox)
        //bpWindow.bodyView.addSubview(itemDescriptionLabel)
    }
    /*
     
     
     override init(frame: CGRect, textContainer: NSTextContainer?) {
     
     super.init(frame: frame, textContainer: textContainer)
     
     self.backgroundColor = UIColor.init(white: CGFloat(0.0), alpha: CGFloat(0.0))
     
     self.isSelectable = false
     
     self.isUserInteractionEnabled = false
     
     
     //self.font = UIFont.init(name: "OpenDyslexic-Regular", size: 12)
     }
     */
    
    func activeItemHasChanged(index: Int) {
        if (index > -1) && (index < (currentEquipmentList.count))
        {
            setActiveEquipmentItemUI(index: index)
        }
        else
        {
            clearActiveInventoryItemUI()
        }
    }
    
    func setActiveEquipmentItemUI(index: Int)
    {
        /*let inventory = getInventory()
        let activeItem = (inventory?.contents[index])!*/
        
        let player = gameplayDelegate.getEntityEngine().player
        
        let equipmentAC = ACEquipment.GetComponent(entity: player!) as! ACEquipment
        
        equipmentAC.weaponsActive = [currentEquipmentList[index].typeInv.weapon!]
        
        let activeItem = (currentEquipmentList[index])
        
        itemNameLabel.text = activeItem.typeInv.name
        itemIconImageView.image = activeItem.typeInv.image
        itemDescriptionTextBox.text = activeItem.getLongDescriptionOfItem()/*activeItem.typeInv.descriptionIIT + "\n" + "\n"
        
        if activeItem.keepOnDeath
        {
            itemDescriptionTextBox.text = itemDescriptionTextBox.text + "This item will be kept upon death."
        }
        else
        {
            if activeItem.typeInv.securableOnDeath
            {
                itemDescriptionTextBox.text = itemDescriptionTextBox.text + "This item was recently acquired and WILL BE LOST ON DEATH. The item cannot be secured on death until your next visit to a human settlement. Simply visiting a human settlement will secure the item."
            }
            else
            {
                itemDescriptionTextBox.text = itemDescriptionTextBox.text + "This item WILL BE LOST ON DEATH. This item CANNOT EVER BE SECURED, even on visiting a human settlement."
            }
        }
        
        if activeItem.typeInv.weapon != nil
        {
            let weaponRef = activeItem.typeInv.weapon!
            
            itemDescriptionTextBox.text = itemDescriptionTextBox.text + "\n" + "\n" + "This weapon has the following attacks:"
            
            for attack in weaponRef.attacks
            {
                itemDescriptionTextBox.text = itemDescriptionTextBox.text + "\n" + "\n" + attack.name
                itemDescriptionTextBox.text = itemDescriptionTextBox.text + "\n" + " - Type: " + Attack.DamageTypeToString(damageType: attack.damageType)
                itemDescriptionTextBox.text = itemDescriptionTextBox.text + "\n" + " - Strength: " + String(attack.strength)
            }
        }*/
    }
    
    func clearActiveInventoryItemUI()
    {
        
    }
    
    func getEquipmentList() -> [InventoryItem] {
        return currentEquipmentList
    }
    
    override func refreshUILocations()
    {
        super.refreshUILocations()
    }
    
    override func breakdownUI()
    {
        super.breakdownUI()
    }
    
    func closeWindow() {
        //dashboardDelegate.closeInventory()
        gameplayUIDelegate.CloseEquipmentMenu()
    }
}
