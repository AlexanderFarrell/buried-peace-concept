//
//  AAFindSurvivor.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 12/8/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAFindSurvivor: AAInteraction {
    
    override init(interactionTypeIn: InteractionTypesEntity) {
        super.init(interactionTypeIn: interactionTypeIn)
        
        self.verbName = "Direct to Camp"
        self.progressiveName = "Guiding"
        
        //TODO: Make Survivors be able to be found from scouts sent out from encampments
    }
    
    override func begin() {
        super.begin()
        
        self.entityDelegate.getEntityHost().endAction(action: self)
    }

}
