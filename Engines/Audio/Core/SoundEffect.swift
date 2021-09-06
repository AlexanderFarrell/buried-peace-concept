//
//  SoundEffect.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/6/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit
import AVFoundation

class SoundEffect: NSObject {
    
    var audioPlayer: AVAudioPlayer?
    
    init(filePath: String) {
        
        let fileURL = Bundle.main.url(forResource: filePath, withExtension: nil)
        
        if fileURL != nil
        {
            do {
                try audioPlayer = AVAudioPlayer.init(contentsOf: fileURL!)
            } catch
            {
                audioPlayer = nil
                print("Failed to load sound effect")
            }
        }
        
        super.init()
    }
    
    func play()
    {
        if audioPlayer!.isPlaying
        {
            audioPlayer!.currentTime = 0
        }
        
        audioPlayer!.play()
    }
    
    func stop()
    {
        if audioPlayer!.isPlaying
        {
            audioPlayer!.currentTime = 0
        }
        
        audioPlayer!.stop()
    }
    
    func loop()
    {
        audioPlayer!.numberOfLoops = -1
    }
    
    func stopLoop()
    {
        audioPlayer!.numberOfLoops = 1
    }
    
    func breakdown()
    {
        audioPlayer = nil
    }
}
