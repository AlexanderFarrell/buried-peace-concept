//
//  EditorViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/17/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

enum CameraModeEditor {
    case AddBlocksTopDownView
    case EditMapSphericalView
}

class EditorViewController: UIViewController, GameplayDelegate {
    
    //MARK: - File
    var legend: LegendGame!
    var worldScene: WorldScene!
    
    //MARK: - Camera
    var focusPoint = TDVector3Make(0.0, 0.0, 0.0)
    var cameraRadius: Float = 0.0
    var cameraInclination: Float = 0.0
    var cameraAzimuth: Float = 0.0
    var cameraMode = CameraModeEditor.EditMapSphericalView
    static let cameraStartRadius: Float = 20.0
    static let cameraStartInclination: Float = 0.25 * Float.pi
    static let cameraStartAzimuth: Float = 0.25 * Float.pi
    static let maxRadius = 100.0
    static let minRadius = 1.0
    
    //MARK: - World
    var macroWorld: MacroWorld!
    var microWorld: MicroWorld!
    
    //MARK: - Set Up Methods
    override func viewDidLoad() {
        assert(legend != nil, "FATAL ERROR: Legend is nil on the gameplay view controller. This must be set in order to run the game.")
        assert(worldScene != nil, "FATAL ERROR: WorldScene is nil on the gameplay view controller. This must be set in order to run the game.")
        
        macroWorld = MacroWorld()
        macroWorld.editorMode = true
        macroWorld.gameplayDelegate = self
        macroWorld.setup()
        
        microWorld = MicroWorld()
        microWorld.gameplayDelegate = self
        microWorld.editorMode = true
        microWorld.setup()
        
        cameraRadius = EditorViewController.cameraStartRadius
        cameraInclination = EditorViewController.cameraStartInclination
        cameraAzimuth = EditorViewController.cameraStartAzimuth
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Update
    func update()
    {
        //TODO: - Remove all the reliance on having an update loop in the editor
        updateCamera()
        
        microWorld.update()
    }
    
    func updateCamera()
    {
        switch cameraMode {
        case .AddBlocksTopDownView:
            cameraRadius = Float(MSCMathHelper.clamp(amo: Double(cameraRadius), min: EditorViewController.minRadius, max: EditorViewController.maxRadius))
            
            let cameraRelativePosition = TDVector3Make(0.0, cameraRadius, 0.0)
            let cameraPosition = TDVector3Add(focusPoint, cameraRelativePosition)
            
            self.microWorld.entityEngine.ActiveCamera.CameraPosition = cameraPosition
            self.microWorld.entityEngine.ActiveCamera.CameraTarget = focusPoint
            self.microWorld.entityEngine.ActiveCamera.CameraUp = TDVector3Make(0.0, 0.0, 1.0) //TODO: Maybe allow Camera Up to be rotatable?
            break
        case .EditMapSphericalView:
            //Limit Spherical XYZ
            cameraRadius = Float(MSCMathHelper.clamp(amo: Double(cameraRadius), min: EditorViewController.minRadius, max: EditorViewController.maxRadius))
            cameraInclination = (cameraInclination > Float.pi/2.0) ? Float.pi/2.0 : cameraInclination
            cameraInclination = (cameraInclination < -Float.pi/2.0) ? -Float.pi/2.0 : cameraInclination
            cameraAzimuth = Float(MSCMathHelper.wrapDouble(amo: Double(cameraAzimuth), max: Double(Float.pi)))
            
            let cameraSphericalCoordinates = TDVector3Make(cameraRadius, cameraInclination, cameraAzimuth)
            let cameraCartesianCoordinates = MSCMathHelper.sphericalToCartesian(sphericalCoordinates: cameraSphericalCoordinates)
            
            let cameraPosition = TDVector3Add(focusPoint, cameraCartesianCoordinates)
            
            self.microWorld.entityEngine.ActiveCamera.CameraPosition = cameraPosition
            self.microWorld.entityEngine.ActiveCamera.CameraTarget = focusPoint
            self.microWorld.entityEngine.ActiveCamera.CameraUp = TDVector3Make(0.0, 1.0, 0.0)
            break
        }
        
        //camera.UpdateCamera(view: self.view)
    }
    
    //MARK: - Draw
    func draw()
    {
        //TODO: Only redraw the world when the camera moves or something is added. All updated meshes need to be completely buffered before redraw ceases.
        microWorld.draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMicroWorld() -> MicroWorld {
        return self.microWorld
    }
    
    func getMacroWorld() -> MacroWorld {
        return self.macroWorld
    }
    
    func getView() -> UIView {
        return self.view
    }
    
    func displayMessage(message: String) {
        assert(false, "Tried to display message in editor mode: " + message)
    }
    
    func displayDamage(xScreen: Double, yScreen: Double, amount: Double, typeOfDamage: DamageTypeASW) {
        assert(false, "Tried to display damage in editor mode: - AMO: " + String(amount))
    }
    
    func getSavedGame() -> SavedGame? {
        //assert(false, "Tried to get the saved game in editor mode.")
        return nil
    }
    
    func getLegend() -> LegendGame {
        return legend
    }
    
    func getWorldScene() -> WorldScene
    {
        return worldScene
    }
    
    func getCave() -> Cave {
        return microWorld.cave
    }
    
    func getEntityEngine() -> EntityEngine {
        return microWorld.entityEngine
    }
    
    func getPhysics() -> Physics {
        return microWorld.physics
    }
    
    func getSoundEngine() -> GameSounds {
        return microWorld.soundEngine
    }
    
    func getActiveCamera() -> RECamera {
        return microWorld.entityEngine.ActiveCamera
    }
    
    func getRenderer() -> Renderer {
        return microWorld.renderer
    }
    
    func getTextureManager() -> TextureManager {
        return microWorld.textureManager
    }
    
    func getRandomMicro() -> ClayRandom {
        assert(false, "Tried to get the microworld random in editor mode.")
        return ClayRandom.init(quality: .HighQualityCRandom)//Will never reach, placed to silence error
    }
    
    func getUnderground() -> Underground {
        return macroWorld.underground
    }
}
