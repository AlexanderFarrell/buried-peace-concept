//
//  AAMonsterDie.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/13/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAMonsterDie: AgentAction {
    var drop: InventoryItem?
    
    override func begin() {
        if drop != nil
        {
            let itemEntity = ItemEntity()
            itemEntity.item = drop!
            itemEntity.x = entityDelegate.getEntityHost().x
            itemEntity.z = entityDelegate.getEntityHost().z
            
            getEntityEngine().addEntity(entity: itemEntity)
        }
        
        self.entityDelegate.getEntityHost().beginAction(action: AADeleteSelf())
    }
}
