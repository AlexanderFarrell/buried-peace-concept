//
//  AAAskStory.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/22/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAAskStory: AAInteraction {
    override func begin() {
        if target! is Human
        {
            let macroHuman = ((target! as! Human).macroIdentity as! MPHuman)
            
            for message in macroHuman.story
            {
                displayMessage(message: target!.name.capitalized + ": " +  message)
            }
        }
        
        self.entityDelegate.getEntityHost().endAction(action: self)
    }
}
