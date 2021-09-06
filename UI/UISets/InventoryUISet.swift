//
//  InventoryUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class InventoryUISet: UISet, BPWindowDelegate, InventoryViewDelegate {
    
    var wpWindow: BPWindow!
    //var dashboardDelegate: DashboardUISetDelegate!
    var gameplayUIDelegate: GameplayUISetDelegate!
    
    let inventoryItemsDisplayWidthPer = 0.5
    
    //UI
    var itemIconImageView: UIImageView!
    var itemNameLabel: UILabel!
    //var itemDescriptionLabel: UILabel!
    var itemDescriptionTextBox: UITextView!
    var attributesTextView: UITextView!
    
    var activeInventoryInt: Int = -1
    
    override init(parent: UIViewController) {
        super.init(parent: parent)
    }
    
    override func placeUI()
    {
        let windowBorderSizeX = Double(parentViewController.view.frame.width) * Constants.ModalWindowDefaultScreenBorderSizePer
        let windowBorderSizeY = Double(parentViewController.view.frame.height) * Constants.ModalWindowDefaultScreenBorderSizePer
        
        wpWindow = BPWindow.init(frame: CGRect.init(x: windowBorderSizeX, y: windowBorderSizeY, width: Double(parentViewController.view.frame.width) - (windowBorderSizeX * 2.0), height: Double(parentViewController.view.frame.height) - (windowBorderSizeY * 2.0)), titleIn: "Inventory", delegate: self)
        
        setupIcon()
        setupLabels()
        
        addView(view: wpWindow)
        
        let inventoryView = InventoryView.init(frame: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: wpWindow.bodyFrame.width * CGFloat(inventoryItemsDisplayWidthPer), height: wpWindow.bodyFrame.height))
        inventoryView.inventoryDelegate = self
        
        wpWindow.bodyView.addSubview(inventoryView)
        
        super.placeUI()
    }
    
    func setupIcon()
    {
        let iconPerSize = 0.2
        let iconBorder = 15.0
        let iconSize = Double(wpWindow.bodyFrame.width) * iconPerSize
        let iconX = Double(wpWindow.bodyFrame.width) * ((((1.0 - inventoryItemsDisplayWidthPer) / 2.0) - (iconPerSize/2.0)) + inventoryItemsDisplayWidthPer)
        
        itemIconImageView = UIImageView.init(frame: CGRect.init(x: iconX, y: iconBorder, width: iconSize, height: iconSize))
        itemIconImageView.backgroundColor = UIColor.black
        
        wpWindow.bodyView.addSubview(itemIconImageView)
    }
    
    func setupLabels()
    {
        let labelPerSize = 0.47
        let labelWidth = Double(wpWindow.bodyFrame.width) * labelPerSize
        let xStart = Double(wpWindow.bodyFrame.width) * ((((1.0 - inventoryItemsDisplayWidthPer) / 2.0) - (labelPerSize/2.0)) + inventoryItemsDisplayWidthPer)
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
        
        itemDescriptionTextBox = UITextView.init(frame: CGRect.init(x: xStart, y: yDescription, width: labelWidth, height: Double(wpWindow.bodyFrame.height) - yDescription), textContainer: nil)
        itemDescriptionTextBox.textColor = Constants.NormalUIColor
        itemDescriptionTextBox.backgroundColor = UIColor.init(white: 1.0, alpha: 0.0)
        itemDescriptionTextBox.isSelectable = false
        itemDescriptionTextBox.isEditable = false
        
        wpWindow.bodyView.addSubview(itemNameLabel)
        wpWindow.bodyView.addSubview(itemDescriptionTextBox)
        //wpWindow.bodyView.addSubview(itemDescriptionLabel)
    }
    
    func activeItemHasChanged(index: Int) {
        if (index > -1) && (index < (getInventory()?.contents.count)!)
        {
            setActiveInventoryItemUI(index: index)
        }
        else
        {
            clearActiveInventoryItemUI()
        }
    }
    
    func setActiveInventoryItemUI(index: Int)
    {
        let inventory = getInventory()
        let activeItem = (inventory?.contents[index])!
        
        itemNameLabel.text = activeItem.typeInv.name
        itemIconImageView.image = activeItem.typeInv.image
        //itemDescriptionLabel.text = activeItem.typeInv.descriptionIIT
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
        }*/
    }
    
    func clearActiveInventoryItemUI()
    {
        
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
        gameplayUIDelegate.CloseInventoryMenu()
    }
    
    func getInventory() -> ACInventory? {
        return self.gameplayDelegate.getEntityEngine().player.components[ACInventory.componentName()] as? ACInventory
    }
}
