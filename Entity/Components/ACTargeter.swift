//
//  ACTargeter.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/4/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol ACTargeterListener {
    func updateTarget(target: Entity, interactions: Set<InteractionTypesEntity>?)
    func targetHasCleared()
}

protocol ACTargeterInteractionsListListener {
    func updateTargetIL(target: Entity, interactions: [AAInteraction]?)
    func targetHasClearedIL()
}

class ACTargeter: AgentComponent {
    var target: Entity?
    var targetVersion = 0
    
    var currentInteractions: [AAInteraction]?
    
    private(set) public var targetChanged: Bool!
    
    private var listeners = Set<NSObject>()
    private var listenersInteractionList = Set<NSObject>()
    
    override class func componentName() -> String {
        return "Targeter"
    }
    
    //MARK: - Update
    
    override func update() {
        targetChanged = false
        
        if target != nil
        {
            if target!.isDeleted
            {
                clearTarget()
            }
            else
            {
                if targetVersion != target!.interactionVersion
                {
                    targetVersion = target!.interactionVersion
                    
                    updateSubscribers()
                }
            }
            
        }
    }
    
    //MARK: - Target Get and Set
    
    func setTarget(newTarget: Entity)
    {
        target = newTarget
        targetVersion = target!.interactionVersion
        
        updateSubscribers()
        
        targetChanged = true
    }
    
    func clearTarget()
    {
        target = nil
        targetChanged = true
        
        currentInteractions = nil
        
        clearTargetOnSubscribers()
    }
    
    func hasTarget() -> Bool
    {
        return (target != nil)
    }
    
    //MARK: - Listener Subscribe and Unsubscribe
    
    func addSubscriber(subscriber: ACTargeterListener)
    {
        if subscriber is NSObject
        {
            listeners.insert(subscriber as! NSObject)
        }
    }
    
    func removeSubscriber(subscriber: ACTargeterListener)
    {
        if subscriber is NSObject
        {
            listeners.remove(subscriber as! NSObject)
        }
    }
    
    func updateSubscribers()
    {
        let interactions = target!.getInteractions()
        
        if currentInteractions != nil
        {
            for interaction in currentInteractions!
            {
                if interaction.isActive
                {
                    interaction.entityDelegate.getEntityHost().endAction(action: interaction)
                }
            }
        }
        
        currentInteractions = [AAInteraction]()
        
        for subscriber in listeners
        {
            (subscriber as! ACTargeterListener).updateTarget(target: target!, interactions: interactions)
        }
        
        for subscriber in listenersInteractionList
        {
            (subscriber as! ACTargeterInteractionsListListener).updateTargetIL(target: target!, interactions: currentInteractions)
        }
    }
    
    func clearTargetOnSubscribers()
    {
        for subscriber in listeners
        {
            (subscriber as! ACTargeterListener).targetHasCleared()
        }
        
        for subscriber in listenersInteractionList
        {
            (subscriber as! ACTargeterInteractionsListListener).targetHasClearedIL()
        }
    }
    
    //MARK: - Listener InteractionList Subscribe and Unsubscribe
    
    func addSubscriberInteractionList(subscriber: ACTargeterInteractionsListListener)
    {
        if subscriber is NSObject
        {
            listenersInteractionList.insert(subscriber as! NSObject)
        }
    }
    
    func removeSubscriberInteractionList(subscriber: ACTargeterInteractionsListListener)
    {
        if subscriber is NSObject
        {
            listenersInteractionList.remove(subscriber as! NSObject)
        }
    }
    
    //MARK: - Interactions
    
    func getInteractionTypes() -> Set<InteractionTypesEntity>?
    {
        var retVal: Set<InteractionTypesEntity>?
        
        if hasTarget()
        {
            retVal = target?.getInteractions()
        }
        else
        {
            retVal = nil
        }
        
        return retVal
    }
}
