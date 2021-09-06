//
//  GameplayObject.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol GameplayDelegate {
    //Global
    
    //Game
    func getMicroWorld() -> MicroWorld
    func getMacroWorld() -> MacroWorld
    func getView() -> UIView
    func displayMessage(message: String)
    func displayDamage(xScreen: Double, yScreen: Double, amount: Double, typeOfDamage: DamageTypeASW)
    //func getProfile() -> Profile
    //func getGameOptions() -> GameOptions
    func getSavedGame() -> SavedGame?
    func getLegend() -> LegendGame
    func getWorldScene() -> WorldScene
    
    //Micro
    func getCave() -> Cave
    func getEntityEngine() -> EntityEngine
    func getPhysics() -> Physics
    func getSoundEngine() -> GameSounds
    
    //Micro Minor
    func getActiveCamera() -> RECamera
    func getRenderer() -> Renderer
    func getTextureManager() -> TextureManager
    func getRandomMicro() -> ClayRandom
    
    //Macro
    func getUnderground() -> Underground
}

class GameplayObject: NSObject, GameplayDelegate {
    
    var gameplayDelegate: GameplayDelegate!
    
    func generate()
    {
        
    }
    
    func load()
    {
        
    }
    
    func setup()
    {
        
    }
    
    func breakdown()
    {
        
    }
    
    func update()
    {
        
    }
    
    func draw()
    {
        
    }
    
    static func GetPListFromFile(pathToLoad: String) -> [String]?
    {
        if let path = Bundle.main.path(forResource: pathToLoad, ofType: "plist")
        {
            if let instanceNamesFromPlist = NSArray.init(contentsOfFile: path) as? [String]
            {
                return instanceNamesFromPlist
            }
        }
        
        return nil
    }
    
    static func GetPListDictionaryFromFile(pathToLoad: String) -> Dictionary<String, String>?
    {
        if let path = Bundle.main.path(forResource: pathToLoad, ofType: "plist")
        {
            /*if let instanceNamesFromPlist = NSArray.init(contentsOfFile: path) as? [String]
            {
                return instanceNamesFromPlist
            }*/
            
            if let instanceNamesFromPlist = NSDictionary.init(contentsOfFile: path) as? Dictionary<String, String>
            {
                return instanceNamesFromPlist
            }
        }
        
        return nil
    }
    
    //Delegate Methods
    func displayMessage(message: String)
    {
        gameplayDelegate.displayMessage(message: message)
    }
    
    func displayDamage(xScreen: Double, yScreen: Double, amount: Double, typeOfDamage: DamageTypeASW)
    {
        gameplayDelegate.displayDamage(xScreen: xScreen, yScreen: yScreen, amount: amount, typeOfDamage: typeOfDamage)
    }
    
    func getRandomMicro() -> ClayRandom
    {
        return gameplayDelegate.getRandomMicro()
    }
    
    func getMicroWorld() -> MicroWorld {
        return gameplayDelegate.getMicroWorld()
    }
    
    func getMacroWorld() -> MacroWorld {
        return gameplayDelegate.getMacroWorld()
    }
    
    func getView() -> UIView {
        return gameplayDelegate.getView()
    }
    
    func getCave() -> Cave
    {
        return gameplayDelegate.getCave()
    }
    
    func getEntityEngine() -> EntityEngine
    {
        return gameplayDelegate.getEntityEngine()
    }
    
    func getPhysics() -> Physics
    {
        return gameplayDelegate.getPhysics()
    }
    
    func getActiveCamera() -> RECamera
    {
        return gameplayDelegate.getEntityEngine().ActiveCamera
    }
    
    func getRenderer() -> Renderer {
        return gameplayDelegate.getMicroWorld().renderer
    }
    
    func getTextureManager() -> TextureManager
    {
        return gameplayDelegate.getTextureManager()
    }
    
    func getUnderground() -> Underground {
        return gameplayDelegate.getUnderground()
    }
    
    func getSoundEngine() -> GameSounds {
        return gameplayDelegate.getSoundEngine()
    }
    
    func getLegend() -> LegendGame{
        return gameplayDelegate.getLegend()
    }
    
    func getWorldScene() -> WorldScene {
        return gameplayDelegate.getWorldScene()
    }
    
    func getSavedGame() -> SavedGame? {
        return gameplayDelegate.getSavedGame()
    }
}
