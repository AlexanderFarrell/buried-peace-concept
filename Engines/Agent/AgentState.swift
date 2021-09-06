//
//  AgentState.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AgentState: AgentElement {
    
    func getInteractionTypes() -> [InteractionTypesEntity]?
    {
        return nil
    }
    
    class func stateName() -> String
    {
        return "base class"
    }
    
    class func HasState(entity: Entity) -> Bool
    {
        return (entity.states[stateName()] != nil)
    }
    
    class func GetState(entity: Entity) -> AgentState?
    {
        if (entity.states[stateName()] != nil)
        {
            return entity.states[stateName()]
        }
        else
        {
            return nil
        }
    }
}
