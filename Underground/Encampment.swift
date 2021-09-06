//
//  Encampment.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/27/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Encampment: UTileContent, NSCoding {
    var name: String = ""
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(personalities, forKey: "Personalities")
        
        /*for personality in personalities
        {
            aCoder.encode(personality, forKey: <#T##String#>)
        }*/
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        personalities = aDecoder.decodeObject(forKey: "Personalities") as! Set<MacroPersonality>
        
        for personality in personalities
        {
            personality.gameplayDelegate = gameplayDelegate
        }
    }
    
    
    override func generate() {
        let totalPopulation = random.nextIntInRange(minValue: 1, maxValue: 10)
        
        var iPop = 0
        
        while iPop < totalPopulation
        {
            let personality = MPHuman()
            
            self.addPersonality(personality: personality)
            
            personality.createPersonality(random: self.tileDelegate!.getParentTile().generationRandom!)
            
            iPop += 1
        }
        
        super.generate()
    }
}
