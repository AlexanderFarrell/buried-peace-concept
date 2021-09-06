//
//  Entity.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum InteractionTypesEntity {
    case Combat
    case Travel
    case GetToKnow
    case Assignment
    case Request
    case Encourage
    case Pickup
    case Find
}

protocol EntityDelegate {
    func getEntityHost() -> Entity
}

class Entity: GameplayObject, EntityDelegate {
    var x: Float = 0.0
    var y: Float = 0.0
    var z: Float = 0.0
    var yaw: Float = 0.0
    var pitch: Float = 0.0
    var name: String = "Nameless"
    
    var validatePhysics = false
    var xLast: Float = 0.0
    var yLast: Float = 0.0
    var zLast: Float = 0.0
    
    var components = Dictionary<String, AgentComponent>()
    var states = Dictionary<String, AgentState>()
    var actions = [AgentAction]()
    
    var interactionVersion = 0
    
    var isEntityInFrustum: Bool = true
    var frustumCullingExempt: Bool = false
    
    var macroIdentity: MacroPersonality?
    
    var isDeleted = false
    
    private var subscribedInteractionStates = [AgentState]()
    
    override func breakdown()
    {
        for component in components.values {
            component.breakdown()
        }
        
        for action in actions {
            action.breakdown()
            
        }
    }
    
    override func update() {
        
        for component in components.values {
            component.update()
        }
        
        var a = 0
        
        while a < actions.count
        {
            actions[a].update()
            
            a += 1
        }
        
        isEntityInFrustum = isInFrustum()//self.gameplayDelegate.getActiveCamera().isPointInFrustum(point: Position(), drawDistance: 300.0)
    }
    
    
    func beginComponent(component: AgentComponent)
    {
        if components[type(of: component).componentName()] == nil
        {
            components[type(of: component).componentName()] = component
            component.gameplayDelegate = self
            component.entityDelegate = self
            component.begin()
        }
    }
    
    func beginState(state: AgentState)
    {
        if states[type(of: state).stateName()] == nil
        {
            states[type(of: state).stateName()] = state
            state.gameplayDelegate = self
            state.entityDelegate = self
            state.begin()
        }
    }
    
    func beginAction(action: AgentAction)
    {
        actions.append(action)
        action.gameplayDelegate = self
        action.entityDelegate = self
        action.isActive = true
        action.begin()
    }
    
    func endComponent(component: AgentComponent)
    {
        components[type(of: component).componentName()]?.end()
        components[type(of: component).componentName()] = nil
    }
    
    func endState(state: AgentState)
    {
        states[type(of: state).stateName()]?.end()
        states[type(of: state).stateName()] = nil
    }
    
    func endAction(action: AgentAction)
    {
        var i = 0
        
        while i < actions.count
        {
            if (action === actions[i])
            {
                actions[i].end()
                action.isActive = false
                actions.remove(at: i)
                i = actions.count + 1
            }
            
            i = i+1
        }
    }GPU
    
    
    func refreshInteractionsOnTargeters()
    {
        interactionVersion += 1
    }
    
    func getEntityHost() -> Entity {
        return self
    }
    
    func Position() -> TDVector3
    {
        return TDVector3Make(x, y, z)
    }
    
    func setPositionWithVector(vector: TDVector3)
    {
        x = vector.v.0
        y = vector.v.1
        z = vector.v.2
    }
    
    func screenPosition(view: UIView) -> TDVector3
    {
        var retVal: TDVector3
        
        let camera = self.gameplayDelegate.getActiveCamera()
        
        let position = TDVector4Make(x, y, z, 1)
        
        let viewProjectionMatrix = TDMatrix4Multiply(camera.ProjectionMatrix, camera.ViewMatrix)
        let transformedPoint = TDMatrix4MultiplyVector4(viewProjectionMatrix, position)
        
        let screenWidth = Float(view.bounds.size.width)
        let screenHeight = Float(view.bounds.size.height)
        
        var screenX = /*roundf*/(((transformedPoint.v.0 / transformedPoint.v.3) + 1) / 2.0) * screenWidth
        var screenY = /*roundf*/((((transformedPoint.v.1 / transformedPoint.v.3) * -1.0) + 1) / 2.0) * screenHeight //Y is inverted to conform with Metal Coordinate Space
        let screenZ = transformedPoint.v.2// * ((screenWidth + screenHeight) / 2.0)
        
        if screenZ < 0
        {
            screenX = screenWidth * 20
            screenY = screenHeight * 20
        }
        
        retVal = TDVector3Make(Float(screenX), Float(screenY), Float(screenZ))
        
        return retVal
    }
    
    func isInFrustum() -> Bool
    {
        var retVal: Bool
        
        let camera = self.gameplayDelegate.getActiveCamera()
        
        let position = TDVector4Make(x, y, z, 1)
        
        let viewProjectionMatrix = TDMatrix4Multiply(camera.ProjectionMatrix, camera.ViewMatrix)
        let transformedPoint = TDMatrix4MultiplyVector4(viewProjectionMatrix, position)
        
        let screenX = (transformedPoint.v.0 / transformedPoint.v.3)
        let screenY = (transformedPoint.v.1 / transformedPoint.v.3) * -1.0
        let screenZ = transformedPoint.v.2
        
        retVal = ((screenX > -1.0) && (screenX < 1.0) && (screenY > -1.0) && (screenY < 1.0) && (screenZ > 0))  
        
        return retVal
    }
    
    func worldMatrix() -> TDMatrix4 {
        var retVal: TDMatrix4!
        
        retVal = TDMatrix4Identity
        
        retVal = TDMatrix4Multiply(retVal, TDMatrix4MakeTranslation(x, y, z))
        retVal = TDMatrix4Multiply(retVal, TDMatrix4MakeYRotation(yaw))
        
        return retVal
    }
}
