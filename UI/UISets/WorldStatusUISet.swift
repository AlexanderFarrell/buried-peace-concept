//
//  WorldStatusUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/24/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class WorldStatusUISet: UISet, BPWindowDelegate {

    var wpWindow: BPWindow!
    //var dashboardDelegate: DashboardUISetDelegate!
    var gameplayUIDelegate: GameplayUISetDelegate!
    
    //UI
    var textReadoutView: UITextView!
    
    override init(parent: UIViewController) {
        super.init(parent: parent)
    }
    
    override func placeUI()
    {
        let windowBorderSizeX = Double(parentViewController.view.frame.width) * Constants.ModalWindowDefaultScreenBorderSizePer
        let windowBorderSizeY = Double(parentViewController.view.frame.height) * Constants.ModalWindowDefaultScreenBorderSizePer
        
        wpWindow = BPWindow.init(frame: CGRect.init(x: windowBorderSizeX, y: windowBorderSizeY, width: Double(parentViewController.view.frame.width) - (windowBorderSizeX * 2.0), height: Double(parentViewController.view.frame.height) - (windowBorderSizeY * 2.0)), titleIn: "Journal", delegate: self)
        
        textReadoutView = UITextView.init(frame: CGRect.init(x: 0.0, y: 0.0, width: wpWindow.bodyFrame.width, height: wpWindow.bodyFrame.height), textContainer: nil)
        textReadoutView.textColor = Constants.NormalUIColor
        textReadoutView.backgroundColor = UIColor.init(white: 1.0, alpha: 0.0)
        textReadoutView.isSelectable = false
        textReadoutView.isEditable = false
        
        textReadoutView.text = getStringOfState()
        /*
 
         
         itemDescriptionTextBox = UITextView.init(frame: CGRect.init(x: xStart, y: yDescription, width: labelWidth, height: Double(wpWindow.bodyFrame.height) - yDescription), textContainer: nil)
         itemDescriptionTextBox.textColor = Constants.NormalUIColor
         itemDescriptionTextBox.backgroundColor = UIColor.init(white: 1.0, alpha: 0.0)
         itemDescriptionTextBox.isSelectable = false
         itemDescriptionTextBox.isEditable = false
 */
        
        addView(view: wpWindow)
        
        super.placeUI()
        
        wpWindow.bodyView.addSubview(textReadoutView)
        
        //wpWindow.bodyView.addSubview(inventoryView)
        
        self.showUI(showChildren: true)
        self.enableUI(enableChildren: true)
    }
    
    func getStringOfState() -> String
    {
        let macroWorld = getMacroWorld()
        
        var outputString = ""
        
        return outputString
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
        gameplayUIDelegate.CloseWorldStatsMenu()
    }
}
