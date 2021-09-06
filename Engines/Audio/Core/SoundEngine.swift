//
//  SoundEngine.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/6/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class SoundEngine: NSObject {
    var soundsLoaded = Dictionary<String, SoundEffect>()
    var currentMusicID: String?
    
    func addSound(path: String, soundID: String)
    {
        if soundsLoaded[soundID] == nil
        {
            let soundEffect = SoundEffect.init(filePath: path)
            
            if soundEffect.audioPlayer != nil
            {
                soundsLoaded[soundID] = soundEffect
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
            soundsLoaded[soundID]!.play()
        }
    }
    
    func playLoopSound(soundID: String)
    {
        if soundsLoaded[soundID] != nil
        {
            soundsLoaded[soundID]!.loop()
            soundsLoaded[soundID]!.play()
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
