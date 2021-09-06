//
//  BoundingSphere.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class BoundingSphere: BoundingObject {
    var centerX: Float = 0.0
    var centerY: Float = 0.0
    var centerZ: Float = 0.0
    var radius: Float = 0.0
    
    func getVectorCenter() -> TDVector3
    {
        return TDVector3Make(centerX, centerY, centerZ)
    }
    
    func setCenterWithVector(vector: TDVector3)
    {
        centerX = vector.v.0
        centerY = vector.v.1
        centerZ = vector.v.2
    }
    
    func isCollidingWithBounds(bounds: BoundingSphere) -> Bool
    {
        let distance = TDVector3Distance(getVectorCenter(), bounds.getVectorCenter())
        
        if (distance < (radius + bounds.radius))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func validateBoundsWithBounds(bounds: BoundingSphere) -> BoundingSphere
    {
        let distance = TDVector3Distance(getVectorCenter(), bounds.getVectorCenter())
        let necessaryDistance = radius + bounds.radius
        
        if (distance < necessaryDistance)
        {
            var inputBoundsPosition = bounds.getVectorCenter()
            let myPosition = self.getVectorCenter()
            let locationRelativeToSelf = TDVector3Make(inputBoundsPosition.v.0 - myPosition.v.0, inputBoundsPosition.v.1 - myPosition.v.1, inputBoundsPosition.v.2 - myPosition.v.2)
            
            inputBoundsPosition = MSCMathHelper.cartesianToSpherical(cartesianCoordinates: locationRelativeToSelf)
            inputBoundsPosition.v.0 = necessaryDistance //Set the radius of the position tp
            inputBoundsPosition = MSCMathHelper.sphericalToCartesian(sphericalCoordinates: inputBoundsPosition)
            
            let position = TDVector3Add(inputBoundsPosition, myPosition)
            
            bounds.setCenterWithVector(vector: position)
            
            return bounds
        }
        else
        {
            return bounds
        }
    }
}
