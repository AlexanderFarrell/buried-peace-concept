//
//  LegendHeader.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 2/8/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

struct LegendHeader: Codable {
    var name: String = "Legend"
    var descriptionLegend: String = "This is where the description of the legend should go! \n \nFill in as much information as you want! Put a hook in to attract your players."
    var displayColorRed: Float = 1.0
    var displayColorGreen: Float = 0.0
    var displayColorBlue: Float = 0.0
    var startingWorldSceneIndex: Int = 0
}
