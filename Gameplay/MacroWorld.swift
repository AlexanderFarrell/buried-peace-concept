//
//  MacroWorld.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class MacroWorld: GameplayObject {
    var underground: Underground = Underground()
    var inventoryManager: InventoryManager = InventoryManager()
    var HumanMaleNames: [String]!
    var HumanFemaleNames: [String]!
    var BossNames: [String]!
    var EncampmentNames: [String]!
    var InstanceNames: [String]!
    var HumanProfessions: [String]!
    
    var editorMode: Bool = false
    
    override func load() {
        underground.gameplayDelegate = gameplayDelegate
        setupWords()
        underground.load()
    }
    
    override func generate() {
        underground.gameplayDelegate = gameplayDelegate
        setupWords()
        underground.generate()
    }
    
    override func setup() {
        underground.gameplayDelegate = gameplayDelegate
        
        setupComponents()
    }
    
    func setupWords()
    {
        HumanMaleNames = GameplayObject.GetPListFromFile(pathToLoad: "HumanMaleNames")
        HumanFemaleNames = GameplayObject.GetPListFromFile(pathToLoad: "HumanFemaleNames")
        BossNames = GameplayObject.GetPListFromFile(pathToLoad: "BossNames")
        EncampmentNames = GameplayObject.GetPListFromFile(pathToLoad: "EncampmentNames")
        InstanceNames = GameplayObject.GetPListFromFile(pathToLoad: "InstanceNames")
        HumanProfessions = GameplayObject.GetPListFromFile(pathToLoad: "HumanProfessions")
    }
    
    func setupComponents()
    {
        underground.setup()
        inventoryManager.setup()
    }
    
    override func breakdown() {
        underground.breakdown()
        inventoryManager.breakdown()
    }
}
