//
//  BioticHunter.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 12/9/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class BioticHunter: Monster {
    let bones = 6
    
    override func setup() {
        let skeleton = ACSkeleton()
        
        let random = getRandomMicro()
        self.name = "Biotic Rocks"
        
        uniqueTexture = false
        self.beginComponent(component: skeleton)
        
        let physiology = ACPhysiology()
        self.beginComponent(component: physiology)
        
        super.setup()
        
        self.meleeAI!.meleeTestStrength = 15.0
        
        (ASProtection.GetState(entity: self) as! ASProtection).CyberResist = 1.0
        (ASProtection.GetState(entity: self) as! ASProtection).BioResist = 0.7
        
        if name == "Ice Hunter"
        {
            (ASProtection.GetState(entity: self) as! ASProtection).PyroResist = -0.8
            (ASProtection.GetState(entity: self) as! ASProtection).ShockResist = -0.1
        }
        
        if name == "Sand Hunter"
        {
            (ASProtection.GetState(entity: self) as! ASProtection).PyroResist = 0.3
            (ASProtection.GetState(entity: self) as! ASProtection).ShockResist = 0.1
            (ASProtection.GetState(entity: self) as! ASProtection).EnergyResist = 0.1
        }
    }
    
    override func setupMesh() {
        var iBone = 0
        
        let masterClayMesh = ClayMesh()
        let scalarDisplacement: Float = 0.2
        let random = getRandomMicro()
        
        while iBone < bones
        {
            let clayMesh = ClayGeometry.createUVSphere(latitudeLines: 3, longitudeLines: 3, radius: 0.3)
            
            for vertex in clayMesh.vertices
            {
                vertex.position = TDVector3Add(vertex.position!, TDVector3Make((random.nextFloatUnit() * random.nextSignFloat()) * scalarDisplacement, (random.nextFloatUnit() * random.nextSignFloat()) * scalarDisplacement, (random.nextFloatUnit() * random.nextSignFloat()) * scalarDisplacement))
                
                vertex.normal = TDVector3Make(0.0, 1.0, 0.0)
                vertex.boneIndices = (index0: iBone, index1: 0, index2: 0, index3: 0)
                vertex.boneWeights = TDVector4Make(1.0, 0.0, 0.0, 0.0)
            }
            
            masterClayMesh.addMeshToMesh(mesh: clayMesh)
            
            iBone += 1
        }
        
        assert(masterClayMesh.vertices.count > 0, "BioticHunter vertex count is 0")
        mesh = masterClayMesh.getMeshVertexPosNorTexBone(renderer: getRenderer())
    }
    
    override func update() {
        let skeleton = (ACSkeleton.GetComponent(entity: self) as! ACSkeleton)
        
        let unitAxis = TDVector3Normalize(TDVector3Make(1.0, 5.0, 20.0))
        
        var iRot = 0
        
        while iRot < skeleton.boneRotations.count
        {
            skeleton.boneRotations[iRot] = TDQuaternionMultiply(skeleton.boneRotations[iRot], TDQuaternionMakeWithAngleAndVector3Axis(0.037, unitAxis))
            
            iRot += 1
        }
        
        super.update()
    }
    
    override func setupTexture() {
        if getRandomMicro().nextBool()
        {
            self.texture = getCave().texturePalette.mainNaturalWall
            self.name = getCave().texturePalette.mainNaturalWallName + " Hunter"
        }
        else
        {
            self.texture = getCave().texturePalette.mainNaturalFloor
            self.name = getCave().texturePalette.mainNaturalFloorName + " Hunter"
        }
    }

}
