//
//  ACInventory.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ACInventory: AgentComponent {
    /*private(set) public*/ var contents = [InventoryItem]()
    
    override class func componentName() -> String {
        return "Inventory"
    }
}
