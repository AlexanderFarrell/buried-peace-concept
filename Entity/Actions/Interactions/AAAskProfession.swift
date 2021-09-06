//
//  AAAskProfession.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/22/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAAskProfession: AAInteraction {
    override func begin() {
        if target! is Human
        {
            let macroHuman = ((target! as! Human).macroIdentity as! MPHuman)
            
            displayMessage(message: target!.name.capitalized + ": I am a " + macroHuman.role)
        }
        
        self.entityDelegate.getEntityHost().endAction(action: self)
    }
}
