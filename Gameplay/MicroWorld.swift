//
//  MicroWorld.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class MicroWorld: GameplayObject {
    var renderer: Renderer!
    var textureManager = TextureManager()
    var soundEngine = GameSounds()
    
    var cave: Cave = Cave()
    var entityEngine: EntityEngine = EntityEngine()
    var physics: Physics = Physics()
    
    var editorMode: Bool = false
    
    var random: ClayRandom!
    
    override func setup() {
        renderer = Renderer.init(view: self.getView())
        
        setupComponents()
        
        if !editorMode
        {
            soundEngine.addSound(path: "BossDie001REP.wav", soundID: "BossDie001", kind: .SoundFx)
            soundEngine.addSound(path: "ExplosionREP.wav", soundID: "Explosion", kind: .SoundFx)
            soundEngine.addSound(path: "Laser002REP.wav", soundID: "Laser002", kind: .SoundFx)
            soundEngine.addSound(path: "Melee001REPLACE.wav", soundID: "Melee001", kind: .SoundFx)
            soundEngine.addSound(path: "MonsterSee001REP.wav", soundID: "MonsterSee001", kind: .SoundFx)
            soundEngine.addSound(path: "Pickup001REP.wav", soundID: "Pickup001", kind: .SoundFx)
            soundEngine.addSound(path: "WeaponWield001REP.wav", soundID: "WeaponWield001", kind: .SoundFx)
            soundEngine.addSound(path: "WeaponWield002REP.wav", soundID: "WeaponWield002", kind: .SoundFx)
        }
    }
    
    override func breakdown() {
        cave.breakdown()
        entityEngine.breakdown()
        physics.breakdown()
        textureManager.breakdown()
        
        soundEngine.soundsLoaded.removeAll()
    }
    
    func setupComponents()
    {
        soundEngine.gameplayDelegate = gameplayDelegate
        physics.gameplayDelegate = gameplayDelegate
        cave.gameplayDelegate = gameplayDelegate
        entityEngine.gameplayDelegate = gameplayDelegate
        
        soundEngine.inEditorMode = editorMode
        physics.inEditorMode = editorMode
        cave.inEditorMode = editorMode
        entityEngine.inEditorMode = editorMode
        
        //We tell each to load the component. The component will take data from the current loaded legend, and saved game if there is one.
        soundEngine.load()
        physics.load()
        cave.load()
        entityEngine.load()
        
        //These methods set up these components
        soundEngine.setup()
        physics.setup()
        cave.setup()
        entityEngine.setup()
        
        if !editorMode
        {
            soundEngine.addSound(path: "TestCaveMusic.mp3", soundID: "CaveAmbient", kind: .Music)
            soundEngine.addSound(path: "Ambient001REPLACE.mp3", soundID: "CaveAmbient2", kind: .Music)
            soundEngine.addSound(path: "WarmHospitality.mp3", soundID: "Peaceful", kind: .Music)
            soundEngine.addSound(path: "Fearless.mp3", soundID: "Instance", kind: .Music)
            soundEngine.addSound(path: "Wandering.mp3", soundID: "Wandering", kind: .Music)
        }
    }
    
    override func update() {
        cave.update()
        entityEngine.update()
    }
    
    override func draw() {
        autoreleasepool {
            renderer.beginDraw()
            renderer.beginRenderPass()
            
            cave.draw()
            entityEngine.draw()
            
            renderer.endRenderPass()
            renderer.endDraw()
        }
    }
}
