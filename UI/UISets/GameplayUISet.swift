
//
//  GameplayUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol GameplayUISetDelegate {
    //func DashboardButtonPress()
    func OpenPauseMenu()
    func ClosePauseMenu()
    func EndGameplay()
    func OpenInventoryMenu()
    func CloseInventoryMenu()
    func OpenEquipmentMenu()
    func CloseEquipmentMenu()
    func OpenWorldStatsMenu()
    func CloseWorldStatsMenu()
    func OpenMapMenu()
    func CloseMapMenu()
}

class GameplayUISet: UISet, GameplayUISetDelegate {
    
    var gameplayViewController: GameplayViewController!
    
    var essentialUISet: EssentialUISet?
    var pauseUISet: PauseUISet?
    var actionUISet: ActionSelectorUISet?
    var consoleUISet: ConsoleUISet?
    var inventoryUISet: InventoryUISet?
    var statusDisplayUISet: StatusDisplayUISet?
    var equipmentUISet: EquipmentUISet?
    var worldStatusUISet: WorldStatusUISet?
    var mapUISet: MapUISet?
    var damageUISet: DamageLabelsUISet?
    
    override init(parent: UIViewController) {
        if parent is GameplayViewController
        {
            gameplayViewController = (parent as! GameplayViewController)
            
            super.init(parent: parent)
        }
        else
        {
            super.init(parent: parent)
            print("Cannot initialize GameplayUISet properly, view controller is not a GameplayViewController")
        }
    }
    
    override func placeUI()
    {
        essentialUISet = EssentialUISet.init(parent: gameplayViewController)
        essentialUISet?.gameplayUISetDelegate = self
        essentialUISet?.placeUI()
        //self.addChildUISet(child: essentialUISet!)
        
        actionUISet = ActionSelectorUISet.init(parent: parentViewController)
        actionUISet?.gameplayDelegate = self
        actionUISet?.placeUI()
        //self.addChildUISet(child: actionUISet!)
        
        consoleUISet = ConsoleUISet.init(parent: parentViewController)
        consoleUISet?.gameplayDelegate = self
        consoleUISet?.placeUI()
        //self.addChildUISet(child: consoleUISet!)
        
        statusDisplayUISet = StatusDisplayUISet.init(parent: parentViewController)
        statusDisplayUISet?.gameplayDelegate = self
        statusDisplayUISet?.placeUI()
        
        damageUISet = DamageLabelsUISet.init(parent: parentViewController)
        damageUISet?.gameplayDelegate = self
        damageUISet?.placeUI()
        
        super.placeUI()
    }
    
    override func refreshUILocations()
    {
        super.refreshUILocations()
    }
    
    /*func DashboardButtonPress()
    {
        if dashboardUISet == nil
        {
            OpenDashboard()
        }
        else
        {
            CloseDashboard()
        }
    }*/
    
    /*func OpenDashboard()
    {
        statusDisplayUISet?.breakdownUI()
        statusDisplayUISet = nil
        
        dashboardUISet = DashboardUISet.init(parent: parentViewController)
        dashboardUISet?.gameplayDelegate = self
        dashboardUISet?.placeUI()
    }
    
    func CloseDashboard()
    {
        dashboardUISet?.breakdownUI()
        dashboardUISet = nil
        
        statusDisplayUISet = StatusDisplayUISet.init(parent: parentViewController)
        statusDisplayUISet?.gameplayDelegate = self
        statusDisplayUISet?.placeUI()
    }*/
    
    func OpenPauseMenu()
    {
        deactivateGameUI()
        
        gameplayViewController.pauseGame()
        
        pauseUISet = PauseUISet.init(parent: parentViewController)
        pauseUISet?.gameplayUISetDelegate = self
        pauseUISet?.placeUI()
    }
    
    func ClosePauseMenu()
    {
        pauseUISet?.breakdownUI()
        pauseUISet = nil
        
        gameplayViewController.unpauseGame()
        
        activateGameUI()
    }
    
    func EndGameplay() {
        gameplayViewController.endGameplay = true
    }
    
    private func activateGameUI()
    {
        essentialUISet?.enableUI(enableChildren: true)
        essentialUISet?.showUI(showChildren: true)
        
        gameplayViewController.EnableJoysticks()
        
        actionUISet = ActionSelectorUISet.init(parent: parentViewController)
        actionUISet?.gameplayDelegate = self
        //self.addChildUISet(child: actionUISet!)
        actionUISet!.placeUI()
        
        consoleUISet = ConsoleUISet.init(parent: parentViewController)
        consoleUISet?.gameplayDelegate = self
        //self.addChildUISet(child: consoleUISet!)
        consoleUISet!.placeUI()
        
        statusDisplayUISet = StatusDisplayUISet.init(parent: parentViewController)
        statusDisplayUISet?.gameplayDelegate = self
        statusDisplayUISet?.placeUI()
        
        damageUISet = DamageLabelsUISet.init(parent: parentViewController)
        damageUISet?.gameplayDelegate = self
        damageUISet?.placeUI()
        
        /*if dashboardUISet != nil
        {
            dashboardUISet?.enableUI(enableChildren: true)
            dashboardUISet?.showUI(showChildren: true)
        }*/
    }
    
    private func deactivateGameUI()
    {
        essentialUISet?.disableUI(disableChildren: true)
        essentialUISet?.hideUI(hideChildren: true)
        
        gameplayViewController.DisableJoysticks()
        
        if consoleUISet != nil
        {
            consoleUISet?.disableUI(disableChildren: true)
            consoleUISet?.hideUI(hideChildren: true)
            consoleUISet = nil
        }
        
        if statusDisplayUISet != nil
        {
            statusDisplayUISet?.disableUI(disableChildren: true)
            statusDisplayUISet?.hideUI(hideChildren: true)
            statusDisplayUISet = nil
        }
        
        /*if dashboardUISet != nil
        {
            dashboardUISet?.disableUI(disableChildren: true)
            dashboardUISet?.hideUI(hideChildren: true)
        }*/
        
        if actionUISet != nil
        {
            actionUISet?.disableUI(disableChildren: true)
            actionUISet?.hideUI(hideChildren: true)
            actionUISet!.breakdownUI()
            actionUISet = nil
        }
    }
    
    func OpenInventoryMenu() {
        deactivateGameUI()
        
        inventoryUISet = InventoryUISet(parent: parentViewController)
        inventoryUISet!.gameplayDelegate = gameplayDelegate
        inventoryUISet!.gameplayUIDelegate = self
        inventoryUISet!.placeUI()
    }
    
    func CloseInventoryMenu() {
        inventoryUISet!.breakdownUI()
        
        activateGameUI()
    }
    
    func OpenEquipmentMenu() {
        deactivateGameUI()
        
        equipmentUISet = EquipmentUISet(parent: parentViewController)
        equipmentUISet!.gameplayDelegate = gameplayDelegate
        equipmentUISet!.gameplayUIDelegate = self
        equipmentUISet!.placeUI()
    }
    
    func CloseEquipmentMenu() {
        equipmentUISet!.breakdownUI()
        
        activateGameUI()
    }
    
    func OpenWorldStatsMenu() {
        deactivateGameUI()
        
        worldStatusUISet = WorldStatusUISet(parent: parentViewController)
        worldStatusUISet!.gameplayDelegate = gameplayDelegate
        worldStatusUISet!.gameplayUIDelegate = self
        worldStatusUISet!.placeUI()
    }
    
    func CloseWorldStatsMenu() {
        worldStatusUISet!.breakdownUI()
        
        activateGameUI()
    }
    
    func OpenMapMenu() {
        deactivateGameUI()
        
        mapUISet = MapUISet(parent: parentViewController)
        mapUISet!.gameplayDelegate = gameplayDelegate
        mapUISet!.gameplayUIDelegate = self
        mapUISet!.placeUI()
    }
    
    func CloseMapMenu() {
        mapUISet!.breakdownUI()
        
        activateGameUI()
    }
    
    override func breakdownUI()
    {
        super.breakdownUI()
    }
}
