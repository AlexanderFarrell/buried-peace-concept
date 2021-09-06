//
//  EssentialUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class EssentialUISet: UISet {
    var gameplayUISetDelegate: GameplayUISetDelegate!
    
    var pauseButton: UIButton!
    var inventoryButton: UIButton!
    var equipmentButton: UIButton!
    var worldStatusButton: UIButton!
    var mapButton: UIButton!
    //var dashboardButton: UIButton!
    
    override init(parent: UIViewController) {
        super.init(parent: parent)
    }
    
    override func placeUI()
    {
        setupPauseButton()
        setupInvButton()
        setupEquipButton()
        setupWorldStatusButton()
        setupMapButton()
        //setupDashboardButton()
        
        super.placeUI()
        
        enableUI(enableChildren: true)
    }
    
    private func setupPauseButton()
    {
        let widthPauseButton = CGFloat(40.0)
        let heightPauseButton = CGFloat(40.0)
        let xPauseButton = CGFloat(5.0)//CGFloat((Float(self.parentViewController.view.bounds.width) / 2) - Float(widthPauseButton/2) - 5.0)
        let yPauseButton = CGFloat(5.0)
        
        pauseButton = UIButton.init(frame: CGRect.init(x: xPauseButton, y: yPauseButton, width: widthPauseButton, height: heightPauseButton))
        //pauseButton.backgroundColor = UIColor.white
        pauseButton.setTitle("This Worked", for: .normal)
        pauseButton.setTitleColor(UIColor.black, for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseButtonPress), for: UIControlEvents.touchUpInside)
        pauseButton.tintColor = Constants.NormalUIColor
        pauseButton.setImage(UIImage.init(named: "PauseIconTintableLow")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
        pauseButton.imageView?.contentMode = .scaleAspectFit
        
        Constants.addStandardShadowUIElements(view: pauseButton, color: Constants.InactiveUIColor, offset: CGSize.init(width: 1, height: 1))
        
        addView(view: pauseButton)
    }
    
    private func setupInvButton()
    {
        let widthInventoryButton = CGFloat(40.0)
        let heightInventoryButton = CGFloat(40.0)
        let xInventoryButton = CGFloat(50.0)//CGFloat((Float(self.parentViewController.view.bounds.width) / 2) - Float(widthInventoryButton/2) - 5.0)
        let yInventoryButton = CGFloat(5.0)
        
        inventoryButton = UIButton.init(frame: CGRect.init(x: xInventoryButton, y: yInventoryButton, width: widthInventoryButton, height: heightInventoryButton))
        //inventoryButton.backgroundColor = UIColor.white
        inventoryButton.setTitle("This Worked", for: .normal)
        inventoryButton.setTitleColor(UIColor.black, for: .normal)
        inventoryButton.addTarget(self, action: #selector(inventoryButtonPress), for: UIControlEvents.touchUpInside)
        inventoryButton.tintColor = Constants.NormalUIColor
        inventoryButton.setImage(UIImage.init(named: "InventoryIconTintableLow")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
        inventoryButton.imageView?.contentMode = .scaleAspectFit
        
        Constants.addStandardShadowUIElements(view: inventoryButton, color: Constants.InactiveUIColor, offset: CGSize.init(width: 1, height: 1))
        
        addView(view: inventoryButton)
    }
    
    private func setupEquipButton()
    {
        let widthEquipmentButton = CGFloat(40.0)
        let heightEquipmentButton = CGFloat(40.0)
        let xEquipmentButton = CGFloat(100.0)//CGFloat((Float(self.parentViewController.view.bounds.width) / 2) - Float(widthEquipmentButton/2) - 5.0)
        let yEquipmentButton = CGFloat(5.0)
        
        equipmentButton = UIButton.init(frame: CGRect.init(x: xEquipmentButton, y: yEquipmentButton, width: widthEquipmentButton, height: heightEquipmentButton))
        //EquipmentButton.backgroundColor = UIColor.white
        equipmentButton.setTitle("This Worked", for: .normal)
        equipmentButton.setTitleColor(UIColor.black, for: .normal)
        equipmentButton.addTarget(self, action: #selector(equipmentButtonPress), for: UIControlEvents.touchUpInside)
        equipmentButton.tintColor = Constants.NormalUIColor
        equipmentButton.setImage(UIImage.init(named: "TempEquipmentIconTintable")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
        equipmentButton.imageView?.contentMode = .scaleAspectFit
        
        Constants.addStandardShadowUIElements(view: equipmentButton, color: Constants.InactiveUIColor, offset: CGSize.init(width: 1, height: 1))
        
        addView(view: equipmentButton)
    }
    
    private func setupWorldStatusButton()
    {
        let widthWorldStatusButton = CGFloat(40.0)
        let heightWorldStatusButton = CGFloat(40.0)
        let xWorldStatusButton = CGFloat(150.0)//CGFloat((Float(self.parentViewController.view.bounds.width) / 2) - Float(widthWorldStatusButton/2) - 5.0)
        let yWorldStatusButton = CGFloat(5.0)
        
        worldStatusButton = UIButton.init(frame: CGRect.init(x: xWorldStatusButton, y: yWorldStatusButton, width: widthWorldStatusButton, height: heightWorldStatusButton))
        //worldStatusButton.backgroundColor = UIColor.white
        worldStatusButton.setTitle("This Worked", for: .normal)
        worldStatusButton.setTitleColor(UIColor.black, for: .normal)
        worldStatusButton.addTarget(self, action: #selector(worldStatusButtonPress), for: UIControlEvents.touchUpInside)
        worldStatusButton.tintColor = Constants.NormalUIColor
        worldStatusButton.setImage(UIImage.init(named: "AssignmentsIconTintableLow")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
        worldStatusButton.imageView?.contentMode = .scaleAspectFit
        
        Constants.addStandardShadowUIElements(view: worldStatusButton, color: Constants.InactiveUIColor, offset: CGSize.init(width: 1, height: 1))
        
        addView(view: worldStatusButton)
    }
    
    private func setupMapButton()
    {
        let widthMapButton = CGFloat(40.0)
        let heightMapButton = CGFloat(40.0)
        let xMapButton = CGFloat(200.0)//CGFloat((Float(self.parentViewController.view.bounds.width) / 2) - Float(widthMapButton/2) - 5.0)
        let yMapButton = CGFloat(5.0)
        
        mapButton = UIButton.init(frame: CGRect.init(x: xMapButton, y: yMapButton, width: widthMapButton, height: heightMapButton))
        //mapButton.backgroundColor = UIColor.white
        mapButton.setTitle("This Worked", for: .normal)
        mapButton.setTitleColor(UIColor.black, for: .normal)
        mapButton.addTarget(self, action: #selector(mapButtonPress), for: UIControlEvents.touchUpInside)
        mapButton.tintColor = Constants.NormalUIColor
        mapButton.setImage(UIImage.init(named: "WorldMapIconTintableLow")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
        mapButton.imageView?.contentMode = .scaleAspectFit
        
        Constants.addStandardShadowUIElements(view: mapButton, color: Constants.InactiveUIColor, offset: CGSize.init(width: 1, height: 1))
        
        addView(view: mapButton)
    }
    
    /*private func setupDashboardButton()
    {
        let widthButton = CGFloat(64.0)
        let heightButton = CGFloat(64.0)
        let xButton = CGFloat((Float(self.parentViewController.view.bounds.width)) - Float(widthButton + 5.0))
        let yButton = CGFloat(5.0)
        
        let fontSize = CGFloat(Int(heightButton) - 3)
        
        dashboardButton = UIButton.init(frame: CGRect.init(x: xButton, y: yButton, width: widthButton, height: heightButton))
        //dashboardButton.backgroundColor = UIColor.init(white: CGFloat(1.0), alpha: CGFloat(0.0))
        dashboardButton.setTitle("This Worked", for: .normal)
        dashboardButton.setTitleColor(UIColor.black, for: .normal)
        dashboardButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        dashboardButton.addTarget(self, action: #selector(dashboardButtonPress), for: UIControlEvents.touchUpInside)
        dashboardButton.tintColor = Constants.NormalUIColor
        dashboardButton.setImage(UIImage.init(named: "MenuButtonIconTintableLow")?.withRenderingMode(.alwaysTemplate), for: UIControlState.normal)
        dashboardButton.imageView?.contentMode = .scaleAspectFit
        
        addView(view: dashboardButton)
    }*/
    
    @objc func pauseButtonPress()
    {
        gameplayUISetDelegate.OpenPauseMenu()
    }
    
    @objc func inventoryButtonPress()
    {
        gameplayUISetDelegate.OpenInventoryMenu()
    }
    
    @objc func equipmentButtonPress()
    {
        gameplayUISetDelegate.OpenEquipmentMenu()
    }
    
    @objc func worldStatusButtonPress()
    {
        gameplayUISetDelegate.OpenWorldStatsMenu()
    }
    
    @objc func mapButtonPress()
    {
        gameplayUISetDelegate.OpenMapMenu()
    }
    
    /*@objc func dashboardButtonPress()
    {
        gameplayUISetDelegate.DashboardButtonPress()
    }*/
    
    override func refreshUILocations()
    {
        super.refreshUILocations()
    }
    
    override func breakdownUI()
    {
        super.breakdownUI()
    }
}
