//
//  ACTapResponder.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/4/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ACTapResponder: AgentComponent {
    var tapRadius: Float = 100.0
    var tapAction: AgentAction!
    var checkRadius: Bool = false
    var radius: Float = 0.0
    
    override func begin() {
        super.begin()
        
        self.getEntityEngine().subscribeToTapResponse(component: self)
    }
    
    func handleTap(xOfTap: Float, yOfTap: Float, distance: Float)
    {
        //We make sure the tap is within distance, if this setting is turned on
        if ((checkRadius) && (radius > distance)) || (!checkRadius)
        {
            if tapAction != nil
            {
                self.entityDelegate.getEntityHost().beginAction(action: tapAction)
            }
        }
    }
    
    func distanceFromTap(xOfTap: Float, yOfTap: Float, view: UIView) -> Float
    {
        let tap = TDVector3Make(xOfTap, yOfTap, 0.0)
        let entity = self.entityDelegate.getEntityHost()
        
        let locationOnScreen = entity.screenPosition(view: view)
        
        /*print("Tap Location X: " + String(xOfTap))
         print("Tap Location Y: " + String(yOfTap))
         print("Entity Location X: " + String(locationOnScreen.v.0))
         print("Entity Location X: " + String(locationOnScreen.v.1))*/
        
        return TDVector3Distance(tap, TDVector3Make(locationOnScreen.v.0, locationOnScreen.v.1, 0.0/*locationOnScreen.v.2*/))
    }
    
    override func breakdown() {
        self.getEntityEngine().unsubscribeToTapResponse(component: self)
    }
    
    override class func componentName() -> String{
        return "TapResponseListener"
    }
}
