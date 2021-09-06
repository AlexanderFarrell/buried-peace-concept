//
//  WorldScene.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 2/14/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

struct WorldScene: Codable {
    var name: String = "Scene"
    var shortDescription: String = "Describe the scene here."
    var cave: CaveSerializable = CaveSerializable()
}
