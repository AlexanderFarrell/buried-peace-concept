//
//  OptionsUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol OptionsUISetDelegate {
    //func getGameOptionsO() -> GameOptions
    //func getProfileO() -> Profile
    func applySettings()
}

class OptionsUISet: UISet, OptionsUISetDelegate {
    
    var accessibilityScreen: AccessibilityOUISet?
    var soundScreen: SoundOUISet?
    var gameplayScreen: GameplayOUISet?
    var videoScreen: VideoOUISet?
    
    /*func getGameOptionsO() -> GameOptions {
        return getGameOptions()
    }
    
    func getProfileO() -> Profile {
        return getProfile()
    }*/
    
    func applySettings() {
        
    }
}
