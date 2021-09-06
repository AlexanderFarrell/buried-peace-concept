//
//  ACSolidEntity.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ACSolidEntity: AgentComponent {
    var boundingRadius: Float = 0.0
    var bounds: BoundingSphere!
    
    override func begin() {
        let entity = self.entityDelegate.getEntityHost()
        let physics = self.gameplayDelegate.getPhysics()
        
        bounds = BoundingSphere()
        bounds.setCenterWithVector(vector: entity.Position())
        bounds.radius = boundingRadius
        
        physics.boundingObjects.insert(bounds)
    }
    
    override func end() {
        let physics = self.gameplayDelegate.getPhysics()
        physics.boundingObjects.remove(bounds)
    }
    
    override func breakdown() {
        self.end()
    }
    
    override class func componentName() -> String {
        return "SolidEntity"
    }
}
