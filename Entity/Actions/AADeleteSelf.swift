//
//  AADeleteSelf.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AADeleteSelf: AgentAction {
    override func begin() {
        let target = self.entityDelegate.getEntityHost()
        let entityEngine = target.getEntityEngine()
        
        if self.entityDelegate.getEntityHost() is DrawableEntity
        {
            (self.entityDelegate.getEntityHost() as! DrawableEntity).visible = false
        }
        
        entityEngine.deleteEntity(entity: target)
    }
}
