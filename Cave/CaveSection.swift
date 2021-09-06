//
//  CaveSection.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 12/28/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class CaveSection: GameplayObject {
    var rooms = Set<Room>()
    
    var genRoomDemand = 0
    var macroType: TileSectionTypes = TileSectionTypes.Natural
}
