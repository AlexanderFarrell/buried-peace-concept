//
//  GameplayViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol GameplayViewControllerUIDelegate {
    func EnableJoysticks()
    func DisableJoysticks()
    func pauseGame()
    func unpauseGame()
}

protocol MapToGameplayDelegate {
    func unpauseGame()
}

class GameplayViewController: UIViewController, GameplayDelegate, MapToGameplayDelegate, GameplayViewControllerUIDelegate {
    
    
    //Data
    var legend: LegendGame!
    var worldScene: WorldScene!
    var savedGame: SavedGame?
    
    //Worlds
    var microWorld: MicroWorld!
    var macroWorld: MacroWorld!
    
    //Touch Properties
    var walkJoystickTouch: UITouch?
    var turnJoystickTouch: UITouch?
    var walkJoystickMidpoint: CGPoint! = CGPoint.zero
    var turnJoystickMidpoint: CGPoint! = CGPoint.zero
    var walkJoystickIsActive: Bool! = false
    var turnJoystickIsActive: Bool! = false
    var walkTranslation: CGPoint! = CGPoint.zero
    
    //States
    var refreshScreen: Bool = true
    var joysticksEnabled: Bool = true
    var endGameplay: Bool = false
    var loadFromFile: Bool = true
    
    //Other View Controllers
    var lvcDelegate: LVCDelegate!
    
    //UISets
    var uiSets = [UISet]()
    var gameplayUISet: GameplayUISet!
    
    private(set) public var TimerDrawLoop: CADisplayLink!
    var isPaused: Bool = false
    
    override func viewDidLoad() {
        assert(legend != nil, "FATAL ERROR: Legend is nil on the gameplay view controller. This must be set in order to run the game.")
        assert(worldScene != nil, "FATAL ERROR: WorldScene is nil on the gameplay view controller. This must be set in order to run the game.")
        
        super.viewDidLoad()
        
        self.view.isMultipleTouchEnabled = true
        
        //Initialize World
        self.initializeMacroWorld()
        self.initializeMicroWorld()
        
        // - Draw Loop
        TimerDrawLoop = CADisplayLink(target: self, selector: #selector(self.draw))
        TimerDrawLoop.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        
        gameplayUISet = GameplayUISet.init(parent: self)
        gameplayUISet.gameplayDelegate = self
        gameplayUISet.placeUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.respondToResignActiveApp), name: Notification.Name(rawValue: "ResigningActiveApp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.respondToBecomeActiveApp), name: Notification.Name(rawValue: "BecomingActiveApp"), object: nil)
        
        microWorld.update()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func startGameplay()
    {
        
    }
    
    func breakdown()
    {
        TimerDrawLoop.invalidate()
        
        microWorld.breakdown()
        macroWorld.breakdown()
    }
    
    func initializeMacroWorld()
    {
        macroWorld = MacroWorld()
        macroWorld.gameplayDelegate = self
        
        macroWorld.setup()
        
        /*if loadFromFile
        {
            macroWorld.load()
        }
        else
        {
            macroWorld.generate()
        }*/
        
    }
    
    func initializeMicroWorld()
    {
        microWorld = MicroWorld()//MicroWorld(view: self.view)
        microWorld.gameplayDelegate = self
        
        microWorld.setup()
        
        /*if loadFromFile
        {
            microWorld.load()
        }
        else
        {
            microWorld.generate()
        }*/
        
    }
    
    @objc func respondToResignActiveApp()
    {
        refreshScreen = false
        
        //pauseGame()
        
        gameplayUISet.OpenPauseMenu()
    }
    
    @objc func respondToBecomeActiveApp()
    {
        //refreshScreen = true
    }
    
    func pauseGame()
    {
        isPaused = true
        refreshScreen = false
        
        DisableJoysticks()
    }
    
    func unpauseGame()
    {
        isPaused = false
        refreshScreen = true
        
        EnableJoysticks()
    }
    
    @objc func draw()
    {
        if refreshScreen
        {
            microWorld.draw()
        }
        
        if !isPaused
        {
            microWorld.update()
        }
        
        if walkJoystickTouch == nil
        {
            walkTranslation = CGPoint.init(x: walkTranslation.x * CGFloat(0.75), y: walkTranslation.y * (CGFloat(0.75)))
            microWorld.entityEngine.player.walkTranslationFromUI = walkTranslation
        }
        
        if endGameplay
        {
            exitGameplay()
        }
    }
    
    func exitGameplay()
    {
        breakdown()
        
        lvcDelegate.returnToMenu()
        
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK: - Handle Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Pause
        if joysticksEnabled
        {
            for touch in touches {
                let touchPoint = touch.location(in: self.view)
                
                if (!walkJoystickIsActive && touchPoint.x < (self.view.bounds.width/2))
                {
                    walkJoystickTouch = touch
                    walkJoystickMidpoint = touchPoint
                    walkJoystickIsActive = true
                    
                    //Set Joystick View
                }
                else if (!turnJoystickIsActive && touchPoint.x >= (self.view.bounds.width/2))
                {
                    turnJoystickTouch = touch
                    turnJoystickMidpoint = touchPoint
                    turnJoystickIsActive = true
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Pause
        
        for touch in touches {
            let touchPoint = touch.location(in: self.view)
            
            //Handle Walk Joystick
            if (walkJoystickIsActive && walkJoystickTouch == touch)
            {
                walkTranslation = CGPoint.init(x: touchPoint.x - walkJoystickMidpoint.x, y: touchPoint.y - walkJoystickMidpoint.y)
                
                microWorld.entityEngine.player.walkTranslationFromUI = walkTranslation
            }
            
            //Handle Turn Joystick
            if (turnJoystickIsActive && turnJoystickTouch == touch)
            {
                let translation = CGPoint.init(x: touchPoint.x - turnJoystickMidpoint.x, y: touchPoint.y - turnJoystickMidpoint.y)
                
                microWorld.entityEngine.player.turnTranslationFromUI = translation
                
                turnJoystickMidpoint = touchPoint
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if (walkJoystickIsActive && walkJoystickTouch == touch)
            {
                walkJoystickIsActive = false
                walkJoystickTouch = nil
                
                walkTranslation = CGPoint.zero
                microWorld.entityEngine.player.walkTranslationFromUI = walkTranslation
            }
            
            if (turnJoystickIsActive && turnJoystickTouch == touch)
            {
                turnJoystickIsActive = false
                turnJoystickTouch = nil
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchesEnded(touches, with: event)
    }
    
    @IBAction func respondToTap(_ sender: UITapGestureRecognizer) {
        var tapToEntityEngine = true
        
        for viewOther in self.view.subviews
        {
            if (viewOther is UIButton)
            {
                let boundsOther = viewOther.frame
                let location = sender.location(in: self.view)
                
                if boundsOther.contains(location)
                {
                    tapToEntityEngine = false
                }
            }
        }
        
        if tapToEntityEngine
        {
            let tapLocation = sender.location(in: self.view)
            
            self.microWorld.entityEngine.respondToTap(xOfTap: Float(tapLocation.x), yOfTap: Float(tapLocation.y))
        }
    }
    //MARK: - Delegate Methods
    
    func EnableJoysticks()
    {
        joysticksEnabled = true
    }
    
    func DisableJoysticks()
    {
        joysticksEnabled = false
        
        turnJoystickIsActive = false
        walkJoystickIsActive = false
        
        if walkJoystickTouch != nil
        {
            walkJoystickTouch = nil
        }
        
        if turnJoystickTouch != nil
        {
            turnJoystickTouch = nil
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        get {
            return true
        }
    }
    
    //Gameplay Delegate Methods
    func displayMessage(message: String)
    {
        gameplayUISet.consoleUISet?.consoleView.addMessage(string: message)
    }
    
    func displayDamage(xScreen: Double, yScreen: Double, amount: Double, typeOfDamage: DamageTypeASW)
    {
        gameplayUISet.damageUISet?.displayDamageLabel(x: xScreen, y: yScreen, typeOfDamage: typeOfDamage, amo: amount)
    }
    
    func getMicroWorld() -> MicroWorld {
        return microWorld
    }
    
    func getRandomMicro() -> ClayRandom {
        return microWorld.random
    }
    
    func getMacroWorld() -> MacroWorld {
        return macroWorld
    }
    
    func getView() -> UIView {
        return self.view
    }
    
    func getCave() -> Cave
    {
        return self.microWorld.cave
    }
    
    func getEntityEngine() -> EntityEngine
    {
        return self.microWorld.entityEngine
    }
    
    func getPhysics() -> Physics
    {
        return self.microWorld.physics
    }
    
    func getRenderer() -> Renderer {
        return microWorld.renderer
    }
    
    func getActiveCamera() -> RECamera
    {
        return getEntityEngine().ActiveCamera
    }
    
    func getSoundEngine() -> GameSounds
    {
        return microWorld.soundEngine
    }
    
    func getTextureManager() -> TextureManager
    {
        return self.microWorld.textureManager
    }
    
    func getUnderground() -> Underground {
        return macroWorld.underground
    }
    
    func getSavedGame() -> SavedGame? {
        return savedGame
    }
    
    func getLegend() -> LegendGame {
        return legend
    }
    
    func getWorldScene() -> WorldScene
    {
        return worldScene
    }
}
