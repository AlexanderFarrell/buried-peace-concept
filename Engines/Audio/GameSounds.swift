//
//  GameSounds.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/6/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum TypeOfSoundToPlay {
    case SoundFx
    case Ambient
    case Music
    case Vocal
}

class GameSounds: MicroWorldComponent {
    //private var profile: Profile!
    
    var soundsLoaded = Dictionary<String, SoundEffect>()
    var typeSoundsLoaded = Dictionary<String, TypeOfSoundToPlay>()
    var currentMusicID: String?
    
    //TODO: Refresh game sounds when the option is changed.
    //TODO: Allow all playing sounds to be paused
    //TODO: Allow for variable amount of volume. The suggestion is to ask for volume when you play a sound. Then we can multiply the options volume with that volume.
    //TODO: For continual volume change, such as walking away from a machine and the sound getting quieter, update the volume in real time. Remember to multiply by the option.
    
    override func setup() {
        //profile = getProfile()
    }
    
    override func load()
    {
        let legend = getLegend()
        var savedGame = getSavedGame()
    }
    
    func addSound(path: String, soundID: String, kind: TypeOfSoundToPlay)
    {
        if soundsLoaded[soundID] == nil
        {
            let soundEffect = SoundEffect.init(filePath: path)
            
            if soundEffect.audioPlayer != nil
            {
                soundsLoaded[soundID] = soundEffect
                typeSoundsLoaded[soundID] = kind
            }
            else
            {
                print("Failed to load sound at " + path)
            }
        }
        else
        {
            print("Sound with ID: '" + soundID + "' already loaded")
        }
    }
    
    func playMusic(newID: String, loop: Bool)
    {
        if currentMusicID != nil
        {
            stopSound(soundID: currentMusicID!)
        }
        
        currentMusicID = newID
        
        if loop
        {
            playLoopSound(soundID: newID)
        }
        else
        {
            playSound(soundID: newID)
        }
    }
    
    func removeSound(soundID: String)
    {
        if soundsLoaded[soundID] != nil
        {
            soundsLoaded[soundID]!.breakdown()
            soundsLoaded[soundID] = nil
        }
    }
    
    func playSound(soundID: String)
    {
        if soundsLoaded[soundID] != nil
        {
            switch typeSoundsLoaded[soundID]!
            {
            case .Ambient:
                //if (profile.gameOptions.AmbientEffectsOn == .MutedAGO) {return}
                //soundsLoaded[soundID]!.audioPlayer!.volume = profile.gameOptions.AmbientEffectsVolume
                break
            case .SoundFx:
                //if (profile.gameOptions.SoundEffectsOn == .MutedAGO) {return}
                //soundsLoaded[soundID]!.audioPlayer!.volume = profile.gameOptions.SoundEffectsVolume
                break
            case .Music:
                //if (profile.gameOptions.MusicOn == .MutedAGO) {return}
                //soundsLoaded[soundID]!.audioPlayer!.volume = profile.gameOptions.MusicVolume
                break
            case .Vocal:
                //if (profile.gameOptions.VocalOn == .MutedAGO) {return}
                //soundsLoaded[soundID]!.audioPlayer!.volume = profile.gameOptions.VocalVolume
                break
            }
            
            soundsLoaded[soundID]!.play()
        }
    }
    
    func playLoopSound(soundID: String)
    {
        if soundsLoaded[soundID] != nil
        {
            switch typeSoundsLoaded[soundID]!
            {
            case .Ambient:
                //if (profile.gameOptions.AmbientEffectsOn == .MutedAGO) {return}
                //soundsLoaded[soundID]!.audioPlayer!.volume = profile.gameOptions.AmbientEffectsVolume
                break
            case .SoundFx:
                //if (profile.gameOptions.SoundEffectsOn == .MutedAGO) {return}
                //soundsLoaded[soundID]!.audioPlayer!.volume = profile.gameOptions.SoundEffectsVolume
                break
            case .Music:
                //if (profile.gameOptions.MusicOn == .MutedAGO) {return}
                //soundsLoaded[soundID]!.audioPlayer!.volume = profile.gameOptions.MusicVolume
                break
            case .Vocal:
                //if (profile.gameOptions.VocalOn == .MutedAGO) {return}
                //soundsLoaded[soundID]!.audioPlayer!.volume = profile.gameOptions.VocalVolume
                break
            }
            
            soundsLoaded[soundID]!.play()
            soundsLoaded[soundID]!.loop()
        }
    }
    
    func turnLoopingOn(soundID: String)
    {
        if soundsLoaded[soundID] != nil
        {
            soundsLoaded[soundID]!.loop()
        }
    }
    
    func turnLoopingOff(soundID: String)
    {
        if soundsLoaded[soundID] != nil
        {
            soundsLoaded[soundID]!.stopLoop()
        }
    }
    
    func stopSound(soundID: String)
    {
        if soundsLoaded[soundID] != nil
        {
            soundsLoaded[soundID]!.stop()
        }
    }
}
