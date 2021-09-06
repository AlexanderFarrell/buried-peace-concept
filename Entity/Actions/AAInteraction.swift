//
//  AAInteraction.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/4/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AAInteraction: AgentAction {
    
    var target: Entity?
    var interactionType: InteractionTypesEntity
    
    init(interactionTypeIn: InteractionTypesEntity) {
        interactionType = interactionTypeIn
    }
}
