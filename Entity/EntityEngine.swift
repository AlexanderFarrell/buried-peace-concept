    //
//  EntityEngine.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class EntityEngine: MicroWorldComponent {
    var ActiveCamera: RECamera!
    var Entities = Set<Entity>()
    var Clusters = Set<EntityCluster>()
    var player: Player!
    var projectileAssetManager = ProjectileAssetManager()
    
    var entitiesToDelete: Set<Entity> = Set<Entity>()
    var deleteEntities: Bool = false
    
    var tapResponseSubscribers: Set<ACTapResponder> = Set<ACTapResponder>()
    
    override func setup() {
        setupCamera()
        setupPlayer()
        
        projectileAssetManager.registerProjectile(identifier: "Default", mesh: ClayGeometry.createUVSphere(latitudeLines: 7, longitudeLines: 7, radius: 0.15).getMeshVertexPosTex(renderer: getRenderer()), texture: RETexture.init(clayImage: ClayImage.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0), renderer: getRenderer(), mipmapped: false))
        
        getRenderer().newMaterial(vertexProgram: "basic_vertexUvpntb", fragmentProgram: "basic_fragmentUvpntb", identifier: "Skeleton")
    }
    
    func setupCamera()
    {
        let camera = RECamera()
        camera.CameraPosition = TDVector3Make(0.0, 1.5, 10.0)
        camera.CameraTarget = TDVector3Make(0.2, 1.3, 0.0)
        camera.CameraUp = TDVector3Make(0.0, 1.0, 0.0)
        camera.NearPlaneDistance = 0.1
        camera.FarPlaneDistance = Float(Constants.maxRenderDistance)
        camera.SetFieldOfViewInDegrees(degrees: Float(Constants.CameraFieldOfViewDefaultInDegrees))
        camera.UpdateCamera(view: self.getView())
        ActiveCamera = camera
    }
    
    override func load()
    {
        let legend = getLegend()
        var savedGame = getSavedGame()
    }
    
    func setupPlayer()
    {
        player = Player()
        addEntity(entity: player)
        
        let targetCube = TargetCube()
        addEntity(entity: targetCube)
    }
    
    override func update() {
        for entity in Entities
        {
            entity.update()
        }
        
        for cluster in Clusters
        {
            cluster.update()
        }
        
        if deleteEntities
        {
            for entity in entitiesToDelete {
                entity.isDeleted = true
                
                /*if entity.memberOfCluster != nil
                {
                    let cluster = entity.memberOfCluster
                    
                    cluster?.entities.remove(entity as! DrawableEntity)
                    entitiesToDelete.remove(entity)
                    
                    entity.breakdown()
                }*/
                Entities.remove(entity)
                entitiesToDelete.remove(entity)
                
                entity.breakdown()
                /*else
                {
                 entities.remove(entity)
                 entitiesToDelete.remove(entity)
                 
                 entity.breakdown()
                }*/
            }
            
            deleteEntities = false
        }
        
        ActiveCamera.UpdateCameraPositionFirstPerson(xPos: player.x, yPos: player.y, zPos: player.z, yaw: player.yaw, pitch: player.pitch, cameraLift: 1.5)
        
        //Implement this later when we have the character model
        //ActiveCamera.UpdateCameraPositionToChase(x: player.x, y: player.y, z: player.z, targetLift: 1.5, yaw: player.yaw, pitch: player.pitch, distance: 0.1)
        ActiveCamera.UpdateCamera(view: self.getView())
        
        let physics = getPhysics()
        
        for entity in Entities
        {
            if entity.validatePhysics
            {
                if !(physics.isPositionValid(position: entity.Position(), radius: 0.1))
                {
                    entity.x = entity.xLast
                    entity.y = entity.yLast
                    entity.z = entity.zLast
                }
                
                entity.xLast = entity.x
                entity.yLast = entity.y
                entity.zLast = entity.z
            }
        }
    }
    
    override func draw() {
        for entity in Entities
        {
            entity.draw()
        }
        
        for cluster in Clusters
        {
            cluster.draw()
        }
    }
    
    func deleteEntity(entity: Entity) {
        entitiesToDelete.insert(entity)
        deleteEntities = true
    }
    
    func addEntity(entity: Entity)
    {
        entity.gameplayDelegate = gameplayDelegate
        entity.setup()
        Entities.insert(entity)
    }
    
    func addCluster(cluster: EntityCluster)
    {
        cluster.gameplayDelegate = gameplayDelegate
        cluster.setup()
        Clusters.insert(cluster)
    }
    
    func subscribeToTapResponse(component: ACTapResponder) {
        tapResponseSubscribers.insert(component)
    }
    
    func unsubscribeToTapResponse(component: ACTapResponder) {
        tapResponseSubscribers.remove(component)
    }
    
    func respondToTap(xOfTap: Float, yOfTap: Float)
    {
        let view = self.gameplayDelegate.getView()
        
        /*var closestDistance: Float = 300.0//Float(view.bounds.width + view.bounds.height)
        var closestTapResponder: ACTapResponder? = nil
        var foundTapResponder: Bool = false
        
        for tapResponder in tapResponseSubscribers
        {
            if tapResponder.entityDelegate.getEntityHost().isEntityInFrustum
            {
                let distance = tapResponder.distanceFromTap(xOfTap: xOfTap, yOfTap: yOfTap, view: view)
                
                if distance < closestDistance
                {
                    closestDistance = distance
                    closestTapResponder = tapResponder
                    foundTapResponder = true
                }
            }
        }
        
        if foundTapResponder
        {
            //closestTapResponder?.handleTap(xOfTap: xOfTap, yOfTap: yOfTap, distance: closestDistance)
            (player.components[ACTargeter.componentName()] as! ACTargeter).setTarget(newTarget: closestTapResponder!.entityDelegate.getEntityHost())
        }
        else
        {
            (player.components[ACTargeter.componentName()] as! ACTargeter).clearTarget()
        }*/
        
        let closestDistance: Float = 100.0
        var closestZ = 1000.0
        var closestTap: ACTapResponder!
        var foundTapResponder: Bool = false
        
        for tapResponder in tapResponseSubscribers
        {
            if tapResponder.entityDelegate.getEntityHost().isEntityInFrustum
            {
                let distance = tapResponder.distanceFromTap(xOfTap: xOfTap, yOfTap: yOfTap, view: view)
                if distance < closestDistance
                {
                    let locInView = tapResponder.entityDelegate.getEntityHost().screenPosition(view: view)
                    
                    if closestZ > Double(locInView.v.2)
                    {
                        closestTap = tapResponder
                        closestZ = Double(locInView.v.2)
                        foundTapResponder = true
                    }
                }
            }
        }
        
        if foundTapResponder
        {
            (player.components[ACTargeter.componentName()] as! ACTargeter).setTarget(newTarget: closestTap!.entityDelegate.getEntityHost())
        }
        else
        {
            (player.components[ACTargeter.componentName()] as! ACTargeter).clearTarget()
        }
    }
}
