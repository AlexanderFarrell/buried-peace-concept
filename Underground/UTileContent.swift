//
//  UTileContent.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class UTileContent: GameplayObject {
    var personalities: Set<MacroPersonality> = Set<MacroPersonality>()
    
    var population: Int
    {
        get {
            return self.personalities.count
        }
    }
    
    var tileDelegate: TileDelegate!
    
    weak var random: ClayRandom!

    func addPersonality(personality: MacroPersonality)
    {
        personality.gameplayDelegate = gameplayDelegate
        
        let parentTile = self.tileDelegate.getParentTile()
        
        personality.xLocation = parentTile.x
        personality.yLocation = parentTile.y
        personality.layerLocation = parentTile.layer
        
        //personality.createPersonality(random: self.tileDelegate.getParentTile().)//.setup()
        
        personalities.insert(personality)
    }
}
