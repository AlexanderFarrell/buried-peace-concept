//
//  UnsettledArea.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/27/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class UnsettledArea: UTileContent {
    var monsterCount = 0
    var placedMonsters = false
    
    override func generate() {
        let hasSurvivor = (random.nextIntMaxValue(maxValue: 3) == 0)
        
        if hasSurvivor
        {
            let personality = MPHuman()
            
            self.addPersonality(personality: personality)
            
            personality.createPersonality(random: self.tileDelegate!.getParentTile().generationRandom!)
        }
        
        super.generate()
    }
}
