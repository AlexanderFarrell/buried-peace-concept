//
//  ClayDoubleSpine.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/1/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class ClayDoubleSpine: NSObject {
    var forwardSpine: ClaySpine
    var backwardSpine: ClaySpine
    
    init(stature: Float, direction: TDVector3, origin: TDVector3) {
        forwardSpine = ClaySpine()
        forwardSpine.stature = stature
        forwardSpine.direction = direction
        forwardSpine.origin = origin
        
        backwardSpine = ClaySpine()
        backwardSpine.stature = stature
        backwardSpine.direction = direction
        backwardSpine.origin = origin
    }
    
    func addNode(outside: ClaySpineNode, inside: ClaySpineNode)
    {
        forwardSpine.addNode(outside: outside, inside: inside)
        backwardSpine.addNode(outside: outside, inside: inside)
    }
    
    func addNodes(out: ClaySpineNode, outToFrontControl: TDVector3, outToFrontWeight: Float, outToBackControl: TDVector3, outToBackWeight: Float, inFront: ClaySpineNode, inBack: ClaySpineNode)
    {
        let outFront = ClaySpineNode()
        outFront.x = out.x
        outFront.height = out.height
        outFront.z = out.z
        outFront.upControl = out.upControl
        outFront.upWeight = out.upWeight
        outFront.downControl = out.downControl
        outFront.downWeight = out.downWeight
        outFront.otherControl = outToFrontControl
        outFront.otherWeight = outToFrontWeight
        
        let outBack = ClaySpineNode()
        outBack.x = out.x
        outBack.height = out.height
        outBack.z = out.z
        outBack.upControl = out.upControl
        outBack.upWeight = out.upWeight
        outBack.downControl = out.downControl
        outBack.downWeight = out.downWeight
        outBack.otherControl = outToBackControl
        outBack.otherWeight = outToBackWeight
        
        forwardSpine.addNode(outside: outFront, inside: inFront)
        backwardSpine.addNode(outside: outBack, inside: inBack)
    }
    
    func addNodes(outFront: ClaySpineNode, outBack: ClaySpineNode, inNode: ClaySpineNode, inToFrontControl: TDVector3, inToFrontWeight: Float, inToBackControl: TDVector3, inToBackWeight: Float)
    {
        let inFront = ClaySpineNode()
        inFront.x = inNode.x
        inFront.height = inNode.height
        inFront.z = inNode.z
        inFront.upControl = inNode.upControl
        inFront.upWeight = inNode.upWeight
        inFront.downControl = inNode.downControl
        inFront.downWeight = inNode.downWeight
        inFront.otherControl = inToFrontControl
        inFront.otherWeight = inToFrontWeight
        
        let inBack = ClaySpineNode()
        inBack.x = inNode.x
        inBack.height = inNode.height
        inBack.z = inNode.z
        inBack.upControl = inNode.upControl
        inBack.upWeight = inNode.upWeight
        inBack.downControl = inNode.downControl
        inBack.downWeight = inNode.downWeight
        inBack.otherControl = inToBackControl
        inBack.otherWeight = inToBackWeight
        
        forwardSpine.addNode(outside: outFront, inside: inFront)
        backwardSpine.addNode(outside: outBack, inside: inBack)
    }
    
    func addNodes(inNode: ClaySpineNode, inToFrontControl: TDVector3, inToFrontWeight: Float, inToBackControl: TDVector3, inToBackWeight: Float, out: ClaySpineNode, outToFrontControl: TDVector3, outToFrontWeight: Float, outToBackControl: TDVector3, outToBackWeight: Float)
    {
        let inFront = ClaySpineNode()
        inFront.x = inNode.x
        inFront.height = inNode.height
        inFront.z = inNode.z
        inFront.upControl = inNode.upControl
        inFront.upWeight = inNode.upWeight
        inFront.downControl = inNode.downControl
        inFront.downWeight = inNode.downWeight
        inFront.otherControl = inToFrontControl
        inFront.otherWeight = inToFrontWeight
        
        let inBack = ClaySpineNode()
        inBack.x = inNode.x
        inBack.height = inNode.height
        inBack.z = inNode.z
        inBack.upControl = inNode.upControl
        inBack.upWeight = inNode.upWeight
        inBack.downControl = inNode.downControl
        inBack.downWeight = inNode.downWeight
        inBack.otherControl = inToBackControl
        inBack.otherWeight = inToBackWeight
        
        let outFront = ClaySpineNode()
        outFront.x = out.x
        outFront.height = out.height
        outFront.z = out.z
        outFront.upControl = out.upControl
        outFront.upWeight = out.upWeight
        outFront.downControl = out.downControl
        outFront.downWeight = out.downWeight
        outFront.otherControl = outToFrontControl
        outFront.otherWeight = outToFrontWeight
        
        let outBack = ClaySpineNode()
        outBack.x = out.x
        outBack.height = out.height
        outBack.z = out.z
        outBack.upControl = out.upControl
        outBack.upWeight = out.upWeight
        outBack.downControl = out.downControl
        outBack.downWeight = out.downWeight
        outBack.otherControl = outToBackControl
        outBack.otherWeight = outToBackWeight
        
        forwardSpine.addNode(outside: outFront, inside: inFront)
        backwardSpine.addNode(outside: outBack, inside: inBack)
    }
    
    func getProjections() -> [ProjectionArea3D]
    {
        var retVal = [ProjectionArea3D]()
        retVal.append(contentsOf: forwardSpine.getProjections())
        retVal.append(contentsOf: backwardSpine.getProjections())
        return retVal
    }
    
    func getReflectedYProjections() -> [ProjectionArea3D]
    {
        return [ProjectionArea3D]()//TODO: Implement Inverted Projections
    }
}
