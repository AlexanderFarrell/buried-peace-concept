//
//  Ligament.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/24/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class Ligament: GameplayObject {
    var typeLigament: LigamentType = LigamentType.Body
    var delegate: PhysiologyDelegate!
    var boneIndex: Int = 0
    
    var positionGlobal: TDVector3
    {
        get {
            let pos = posLocal
            
            let rotatedPosition = TDMatrix4MultiplyVector3(TDMatrix4MakeYRotation(delegate.getEntityYaw()), pos)
            let translatedPosition = TDVector3Add(rotatedPosition, delegate.getEntityPosition())
            
            return translatedPosition
        }
        
        set {
            let pos = newValue
            
            let translatedPosition = TDVector3Subtract(pos, delegate.getEntityPosition())
            let rotatedPosition = TDMatrix4MultiplyVector3(TDMatrix4MakeYRotation(-delegate.getEntityYaw()), translatedPosition)
            
            positionLocal = rotatedPosition
        }
    }
    
    var positionLocal: TDVector3
    {
        get {
            return posLocal
        }
        
        set {
            if constrainedToParent
            {
                let connectedPosition = TDVector3Add(parentConnectedPosition, parentLigament!.positionLocal)
                
                if maxDistanceToParent < TDVector3Distance(newValue, connectedPosition)//Translate the parent coordinates by its own position
                {
                    let direction = TDVector3Subtract(newValue, connectedPosition)
                    let normalDirection = TDVector3Normalize(direction)
                    let scaledDirection = TDVector3MultiplyScalar(normalDirection, maxDistanceToParent)
                    let newPosition = TDVector3Add(connectedPosition, scaledDirection)
                    
                    posLocal = newPosition
                }
                else
                {
                    posLocal = newValue
                }
            }
            else
            {
                posLocal = newValue
            }
        }
    }
    
    private var posLocal: TDVector3 = TDVector3Make(0.0, 0.0, 0.0)
    
    //Parent
    var parentLigament: Ligament?
    var parentConnectedPosition: TDVector3!
    var maxDistanceToParent: Float!
    var constrainedToParent: Bool = false
    
    func canMoveToGlobalPosition(globalPosition: TDVector3) -> Bool
    {
        return true
    }
    
    func canMoveToLocalPosition(localPosition: TDVector3) -> Bool
    {
        return true
    }
}
