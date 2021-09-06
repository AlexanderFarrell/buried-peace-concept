//
//  Chapter.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/31/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

struct Chapter: Codable {
    var name: String = "Chapter"
    var shortDescription: String = "Chapter description goes here"
    var cave: CaveSerializable = CaveSerializable()
    var displayColorRed: Float = 1.0
    var displayColorGreen: Float = 0.0
    var displayColorBlue: Float = 0.0
}
