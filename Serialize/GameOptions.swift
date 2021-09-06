//
//  GameOptions.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

//MARK: - Accessibility
enum ColorBlindnessGameOption: Int
    //From https://nei.nih.gov/health/color_blindness/facts_about
{
    case ProtanomalyCBGP = 1 //Red to yellow are greener. Colors not bright
    case ProtanopiaCGGP = 2 //Red appears black, some orange and yellow are all yellow
    case DeuteranomalyCGBP = 3 //Yellow to green are redder, hard to tell difference between violet and blue
    case DeuteranopiaCGBP = 4 //Reds are brownish-yellow, greens are beige
    case TritanomalyCGBP = 5 //Blue appears greener, difficult to tell yellow and red from pink
    case TritanopiaCGBP = 6 //Blue is green and yellow appears violet or light grey
    case RedConeMonochromacyCGBP = 7 //Cannot distinquish colors at all, may have uncontrollable eye movements
    case GreenConeMonochromacyCGBP = 8 //Cannot distinquish colors at all, may have uncontrollable eye movements
    case BlueConeMonochromacyCGBP = 9 //Cannot distinquish colors at all, may have uncontrollable eye movements
    case AchromatopsiaCGBP = 10 //Also RodConeMonochromacy; Very uncomfortable with bright environments!!! See the world as black, white and gray
    case FullColorAndShadeCGBP = 0 //Allows full color to be displayed
}

enum EpilepsyGameOption: Int {
    case ReduceFlickeringEventsEpGO = 1 //Removes and reduces flickering events
    case AllowFlickeringEventsEpGO = 0 //Allows flickering events
}

enum DyslexiaGameOption: Int
{
    case DyslexicFontsOn = 1 //Substitutes dyslexic fonts in labels which are to be read
    case GameFontsOn = 0 //Activates regular fonts
}

enum UIInteractionGameOption: Int {
    case InputDeviceUIIGO = 1 //Interacts with the UI based on an input device
    case TouchUIIGO = 0 //Allows UI to be controlled by touch
}

enum ReadingSpeedGameOption: Int
{
    case NormalRSGO = 0 //Displays messages for the normal amount
    case FastRSGO = 1 //Displays messages for a shorter time
    case VeryFastRSGO = 2 //Displays messages for a very short time
}

enum AudioOnGameOption: Int {
    case OnAGO = 0 //Audio is on. Note if the device is on silent, audio will still not play
    case MutedAGO = 1 //Audio is muted
}

class GameOptions: NSObject {
    //Accessibility
    var ColorBlindnessFilter: ColorBlindnessGameOption = ColorBlindnessGameOption.FullColorAndShadeCGBP
    var Epilepsy: EpilepsyGameOption = EpilepsyGameOption.AllowFlickeringEventsEpGO
    var Dyslexia: DyslexiaGameOption = DyslexiaGameOption.DyslexicFontsOn
    
    var ReadingSpeed: ReadingSpeedGameOption = ReadingSpeedGameOption.NormalRSGO
    var ConsoleNumberOfMessages: Int = 7
    
    //Audio
    var SoundEffectsOn: AudioOnGameOption = AudioOnGameOption.OnAGO
    var SoundEffectsVolume: Float = 0.7
    
    var AmbientEffectsOn: AudioOnGameOption = AudioOnGameOption.OnAGO
    var AmbientEffectsVolume: Float = 0.7
    
    var MusicOn: AudioOnGameOption = AudioOnGameOption.OnAGO
    var MusicVolume: Float = 0.7
    
    var VocalOn: AudioOnGameOption = AudioOnGameOption.OnAGO
    var VocalVolume: Float = 0.7
    
    func loadFromDefaults(profile: String)
    {
        let defaults = UserDefaults.standard
        
        ColorBlindnessFilter = ColorBlindnessGameOption(rawValue: defaults.integer(forKey: profile + "ColBliFil"))!
        Epilepsy = EpilepsyGameOption(rawValue: defaults.integer(forKey: profile + "Epi"))!
        Dyslexia = DyslexiaGameOption(rawValue: defaults.integer(forKey: profile + "Dys"))!
        ReadingSpeed = ReadingSpeedGameOption(rawValue: defaults.integer(forKey: profile + "ReaSpe"))!
        
        SoundEffectsOn = AudioOnGameOption(rawValue: defaults.integer(forKey: profile + "SouFXOn"))!
        SoundEffectsVolume = defaults.float(forKey: profile + "SouFXVol")
        AmbientEffectsOn = AudioOnGameOption(rawValue: defaults.integer(forKey: profile + "AmbFXOn"))!
        AmbientEffectsVolume = defaults.float(forKey: profile + "AmbFXVol")
        MusicOn = AudioOnGameOption(rawValue: defaults.integer(forKey: profile + "MusOn"))!
        MusicVolume = defaults.float(forKey: profile + "MusVol")
        VocalOn = AudioOnGameOption(rawValue: defaults.integer(forKey: profile + "VocOn"))!
        VocalVolume = defaults.float(forKey: profile + "VocVol")
    }
    
    func createToDefaults(profile: String)
    {
        let defaults = UserDefaults.standard
        
        defaults.set(ColorBlindnessFilter.rawValue, forKey: profile + "ColBliFil")
        defaults.set(Epilepsy.rawValue, forKey: profile + "Epi")
        defaults.set(Dyslexia.rawValue, forKey: profile + "Dys")
        defaults.set(ReadingSpeed.rawValue, forKey: profile + "ReaSpe")
        defaults.set(SoundEffectsOn.rawValue, forKey: profile + "SouFXOn")
        defaults.set(SoundEffectsVolume, forKey: profile + "SouFXVol")
        defaults.set(AmbientEffectsOn.rawValue, forKey: profile + "AmbFXOn")
        defaults.set(AmbientEffectsVolume, forKey: "AmbFXVol")
        defaults.set(MusicOn.rawValue, forKey: profile + "MusOn")
        defaults.set(MusicVolume, forKey: profile + "MusVol")
        defaults.set(VocalOn.rawValue, forKey: profile + "VocOn")
        defaults.set(VocalVolume, forKey: profile + "VocVol")
    }
    
    class func ReadingSpeedToGameSteps(readingSpeed: ReadingSpeedGameOption) -> Int
    {
        switch readingSpeed {
        case ReadingSpeedGameOption.NormalRSGO:
            return 240
        case ReadingSpeedGameOption.FastRSGO:
            return 180
        case ReadingSpeedGameOption.VeryFastRSGO:
            return 150
        }
    }
}
