//
//  AABlankInteraction.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/4/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AABlankInteraction: AAInteraction {
    override func begin() {
        super.begin()
        
        self.entityDelegate.getEntityHost().endAction(action: self)
    }
}
