//
//  Boss.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/8/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Boss: Monster {
    
    override func setup() {
        super.setup()
        
        self.name = "Boss"
        
        let protection = (ASProtection.GetState(entity: self) as! ASProtection)
        protection.Health = 5000
        protection.MaxHealth = 5000
        
        self.meleeAI!.meleeTestStrength = 15.0
        
        //walkAction.walkSpeed = 0.01
        //walkAction.maxWaitTime = 700
        //walkAction.maxWalkTime = 90
    }
    
    override func setupMesh()
    {
        let clayMesh = ClayGeometry.createUVSphere(latitudeLines: 20, longitudeLines: 20, radius: 3.5)
        clayMesh.translateVertices(translation: TDVector3Make(0.0, 4.0, 0.0))
        
        mesh = clayMesh.getMeshVertexPosTex(renderer: getRenderer())
    }
    
    override func setupTexture()
    {
        texture = RETexture.init(textureName: "Ore001", device: getRenderer().device)
    }
}
