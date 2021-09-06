//
//  AgentComponent.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AgentComponent: AgentElement {
    override func draw()
    {
        
    }
    
    class func componentName() -> String
    {
        return "base class"
    }
    
    class func HasComponent(entity: Entity) -> Bool
    {
        return (entity.components[componentName()] != nil)
    }
    
    class func GetComponent(entity: Entity) -> AgentComponent?
    {
        if (entity.components[componentName()] != nil)
        {
            return entity.components[componentName()]
        }
        else
        {
            return nil
        }
    }
}
