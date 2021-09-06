//
//  AgentElement.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class AgentElement: GameplayObject {
    var entityDelegate: EntityDelegate!
    
    func begin()
    {
        //Called upon instanciating the element and placing it on an entity.
    }
    
    override func update()
    {
        //Called during the game update loop. Perform any recurring logic.
    }
    
    func end()
    {
        //Called upon deleting the element.
    }
    
    override func breakdown() 
    {
        //Called when the entity is set for deletion. Perform any last second code for the entity.
    }
}
