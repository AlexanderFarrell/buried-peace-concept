//
//  AADeleteEntity.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AADeleteEntity: AgentAction {
    var target: Entity?
    
    override func begin() {
        if target != nil
        {
            target!.beginAction(action: AADeleteSelf())
        }
    }
}
