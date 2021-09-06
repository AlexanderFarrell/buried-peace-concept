//
//  InventoryItemType.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class InventoryItemType: GameplayObject {
    var name: String = "Unknown Object"
    var descriptionIIT = "No Data"
    var tags: [String] = [String]()
    var weapon: Weapon?
    var image: UIImage?
    var securableOnDeath = true
    
    init(nameIn: String, tagsIn: [String]) {
        name = nameIn
        tags = tagsIn
        
        super.init()
    }
    
    init(weaponIn: Weapon, additionalTags: [String] = [String]()) {
        
        name = weaponIn.name
        descriptionIIT = weaponIn.descriptionIIT
        
        tags = [String]()
        tags.append(contentsOf: additionalTags)
        tags.append("Weapon")
        
        weapon = weaponIn
        
        super.init()
    }
}
