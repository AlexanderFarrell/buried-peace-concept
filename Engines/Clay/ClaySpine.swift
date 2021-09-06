//
//  ClaySpine.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/1/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class ClaySpine: NSObject {
    //Global
    var stature: Float = 1.0
    var direction: TDVector3 = TDVector3Make(0.0, 1.0, 0.0)
    var origin: TDVector3 = TDVector3Make(0.0, 0.0, 0.0)
    
    //Data
    var outerNodes: [ClaySpineNode] = [ClaySpineNode]()
    var innerNodes: [ClaySpineNode] = [ClaySpineNode]()
    
    func addNode(outside: ClaySpineNode, inside: ClaySpineNode)
    {
        outerNodes.append(outside)
        innerNodes.append(inside)
    }
    
    func getProjections() -> [ProjectionArea3D]
    {
        var iNode = 0
        var retVal = [ProjectionArea3D]()
        
        if outerNodes.count < 2
        {
            return retVal
        }
        
        assert(outerNodes.count == innerNodes.count, "The number of outer nodes are different than the number of inner nodes.")
        
        while iNode < outerNodes.count-1
        {
            let outUp = outerNodes[iNode]
            let outDown = outerNodes[iNode+1]
            let inUp = innerNodes[iNode]
            let inDown = innerNodes[iNode+1]
            
            let outUpPos = TDVector3Make(outUp.x * stature, outUp.height * stature, outUp.z * stature)
            let outDownPos = TDVector3Make(outUp.x * stature, outUp.height * stature, outUp.z * stature)
            let inUpPos = TDVector3Make(outUp.x * stature, outUp.height * stature, outUp.z * stature)
            let inDownPos = TDVector3Make(outUp.x * stature, outUp.height * stature, outUp.z * stature)
            
            let topLength = TDVector3Distance(outUpPos, inUpPos)
            let leftLength = TDVector3Distance(outUpPos, outDownPos)
            let bottomLength = TDVector3Distance(outDownPos, inDownPos)
            let rightLength = TDVector3Distance(inUpPos, inDownPos)
            
            var topLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: outUpPos), pointTwoIn: ClayPoint3D.init(vector: inUpPos), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(outUp.otherControl), outUp.otherWeight * topLength), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(inUp.otherControl), inUp.otherWeight * topLength))
            var bottomLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: outDownPos), pointTwoIn: ClayPoint3D.init(vector: inDownPos), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(outDown.otherControl), outDown.otherWeight * topLength), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(inDown.otherControl), inDown.otherWeight * topLength))
            var leftLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: outUpPos), pointTwoIn: ClayPoint3D.init(vector: outDownPos), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(outUp.downControl), outUp.downWeight * leftLength), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(outDown.upControl), outDown.upWeight * leftLength))
            var rightLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: inUpPos), pointTwoIn: ClayPoint3D.init(vector: inDownPos), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(inUp.downControl), inUp.downWeight * leftLength), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(inDown.upControl), inDown.upWeight * leftLength))
            
            let surface = ProjectionArea3D.init(left: leftLine, right: rightLine, top: topLine, bottom: bottomLine)
            
            retVal.append(surface)
            
            iNode += 1
        }
        
        return retVal
    }
    
    func getReflectedYProjections() -> [ProjectionArea3D]
    {
        var iNode = 0
        var retVal = [ProjectionArea3D]()
        
        if outerNodes.count < 2
        {
            return retVal
        }
        
        assert(outerNodes.count == innerNodes.count, "The number of outer nodes are different than the number of inner nodes.")
        
        while iNode < outerNodes.count-1
        {
            let outUp = outerNodes[iNode]
            let outDown = outerNodes[iNode+1]
            let inUp = innerNodes[iNode]
            let inDown = innerNodes[iNode+1]
            
            let outUpPos = TDVector3Make(outUp.x * stature * -1, outUp.height * stature, outUp.z * stature)
            let outDownPos = TDVector3Make(outUp.x * stature * -1, outUp.height * stature, outUp.z * stature)
            let inUpPos = TDVector3Make(outUp.x * stature * -1, outUp.height * stature, outUp.z * stature)
            let inDownPos = TDVector3Make(outUp.x * stature * -1, outUp.height * stature, outUp.z * stature)
            
            let topLength = TDVector3Distance(outUpPos, inUpPos)
            let leftLength = TDVector3Distance(outUpPos, outDownPos)
            let bottomLength = TDVector3Distance(outDownPos, inDownPos)
            let rightLength = TDVector3Distance(inUpPos, inDownPos)
            
            var topLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: outUpPos), pointTwoIn: ClayPoint3D.init(vector: inUpPos), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(outUp.otherControlXInvert), outUp.otherWeight * topLength), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(inUp.otherControlXInvert), inUp.otherWeight * topLength))
            var bottomLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: outDownPos), pointTwoIn: ClayPoint3D.init(vector: inDownPos), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(outDown.otherControlXInvert), outDown.otherWeight * topLength), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(inDown.otherControlXInvert), inDown.otherWeight * topLength))
            var leftLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: outUpPos), pointTwoIn: ClayPoint3D.init(vector: outDownPos), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(outUp.downControlXInvert), outUp.downWeight * leftLength), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(outDown.upControlXInvert), outDown.upWeight * leftLength))
            var rightLine = ClayLine3D.init(pointOneIn: ClayPoint3D.init(vector: inUpPos), pointTwoIn: ClayPoint3D.init(vector: inDownPos), controlPointOneIn: TDVector3MultiplyScalar(TDVector3Normalize(inUp.downControlXInvert), inUp.downWeight * leftLength), controlPointTwoIn: TDVector3MultiplyScalar(TDVector3Normalize(inDown.upControlXInvert), inDown.upWeight * leftLength))
            
            let surface = ProjectionArea3D.init(left: leftLine, right: rightLine, top: topLine, bottom: bottomLine)
            
            retVal.append(surface)
            
            iNode += 1
        }
        
        return retVal
    }
}
