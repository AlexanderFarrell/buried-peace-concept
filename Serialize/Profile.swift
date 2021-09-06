//
//  Profile.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/10/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Profile: GameplayObject {
    var gameOptions: GameOptions = GameOptions()
    var name = "Hope"
    
    override func setup() {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: name + "HasCreatedProfile")
        {
            //Load the profile
            gameOptions.loadFromDefaults(profile: name)
        }
        else
        {
            //Create the profile
            gameOptions.createToDefaults(profile: name)
            
            //Set the Bool
            defaults.set(true, forKey: name + "HasCreatedProfile")
        }
        
        super.setup()
    }
}
