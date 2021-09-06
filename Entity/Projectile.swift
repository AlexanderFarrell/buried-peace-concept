//
//  Projectile.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Projectile: DrawableEntity {
    var identifier: String? = "Default"
    var target: Entity!
    var targeter: Entity!
    var stepsToHit: Int! = 5
    var currentStep: Int = 0
    var startLocation: TDVector3!
    var actionToGive: AgentAction?
    var trajectory: Float = 0.0
    var renderAfterHitSteps: Int = 0
    
    override func setup() {
        
        
        if ((identifier != nil) && (target != nil) &&  (targeter != nil))
        {
            startLocation = targeter.Position()
            
            let projectileAssetManager = getEntityEngine().projectileAssetManager
            
            self.texture = projectileAssetManager.getTextureFor(identifier: identifier!)!
            self.mesh = projectileAssetManager.getMeshFor(identifier: identifier!)!
        }
        else
        {
            self.beginAction(action: AADeleteSelf())
        }
        
        super.setup()
    }
    
    override func breakdown() {
        self.transform.Delete()
    }
    
    override func update() {
        let amo = Float(currentStep)/Float(stepsToHit)
        let distance = TDVector3Distance(startLocation, target!.Position()) //We do need to recalculate this each time, because the target could move and it would change the distance.
        
        let nonLiftedDistance = TDVector3Lerp(startLocation, target!.Position(), amo)
        
        let lift = (distance * trajectory) * (0.5 + (0.5 * (cos(amo * Float.pi * 2)))) * 0.25
        
        let finalDistance = TDVector3Add(TDVector3Make(0.0, lift, 0.0), nonLiftedDistance)
        
        self.setPositionWithVector(vector: finalDistance)
        
        currentStep += 1
        
        if currentStep > stepsToHit
        {
            if actionToGive != nil
            {
                target!.beginAction(action: actionToGive!)
            }
            
            self.beginAction(action: AADeleteSelf())
        }
        
        super.update()
    }
}
