//
//  InventoryManager.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class InventoryManager: GameplayObject {
    
    private var inventoryTypes = Dictionary<String, InventoryItemType>()
    private var inventoryTypesByTag = Dictionary<String, Set<InventoryItemType>>()
    
    func addInventoryType(typeInv: InventoryItemType, identifier: String)
    {
        inventoryTypes[identifier] = typeInv
        
        for tag in typeInv.tags
        {
            if inventoryTypesByTag[tag] == nil
            {
                inventoryTypesByTag[tag] = Set<InventoryItemType>()
            }
            
            inventoryTypesByTag[tag]!.insert(typeInv)
        }
    }
    
    func getInventoryType(identifier: String) -> InventoryItemType?
    {
        let retVal = inventoryTypes[identifier]
        
        if retVal == nil
        {
            print("There is no InventoryItemType registered as a " + identifier + ". Returning nil for the InventoryItemType.")
        }
        
        return retVal
    }
    
    func removeInventoryType(identifier: String)
    {
        let typeToRemove = inventoryTypes[identifier]
        
        if typeToRemove != nil
        {
            for tag in typeToRemove!.tags
            {
                inventoryTypesByTag[tag]!.remove(typeToRemove!)
                
                if inventoryTypesByTag[tag]!.count < 1
                {
                    inventoryTypesByTag[tag] = nil
                }
            }
            
            inventoryTypes[identifier] = nil
        }
        else
        {
            print("InventoryItemType with the identifier: " + identifier + " was either never registered, or has already been removed. ")
        }
    }
    
    func getTypesByTag(tag: String) -> Set<InventoryItemType>?
    {
        let retVal = inventoryTypesByTag[tag]
        
        if retVal == nil
        {
            print("There are no registered InventoryItemTypes with the tag " + tag + ". Returning nil for the requested set.")
        }
        
        return retVal
    }
}
