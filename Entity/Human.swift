//
//  Human.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/8/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum DomesticStatusHuman {
    case InCamp
    case Survivor
    case OnAssignment
}

class Human: DrawableEntity {
    var interactionsToGive = Set<InteractionTypesEntity>()
    var domesticStatus: DomesticStatusHuman = DomesticStatusHuman.InCamp
    
    override func setup() {
        
        //self.mesh = ClayBox.makeBox(xCenter: 0.0, yCenter: 0.9, zCenter: 0.0, xLength: 0.75, yLength: 1.8, zLength: 0.75).getClayMesh(detail: 2).getMeshVertexPosTex(renderer: getRenderer())
        //self.texture = RETexture.init(clayImage: ClayImage.init(red: getRandomMicro().nextFloatUnit(), green: getRandomMicro().nextFloatUnit(), blue: getRandomMicro().nextFloatUnit(), alpha: 1.0), renderer: getRenderer(), mipmapped: false)
        
        self.name = macroIdentity!.name//"Human Survivor"
        
        let randomWalk = AARandomWalk()
        randomWalk.walkSpeed = 0.03
        randomWalk.maxWaitTime = 400
        randomWalk.maxWalkTime = 200
        self.beginAction(action: randomWalk)
        
        let tapResponder = ACTapResponder()
        self.beginComponent(component: tapResponder)
        
        self.validatePhysics = true
        
        let random = getRandomMicro()
        
        switch domesticStatus {
        case .InCamp:
            interactionsToGive.insert(.GetToKnow)
            
            if random.nextBool()
            {
                interactionsToGive.insert(.Assignment)
            }
            
            if random.nextBool()
            {
                interactionsToGive.insert(.Request)
            }
            break
        case .OnAssignment:
            break
        case .Survivor:
            interactionsToGive.insert(.Find)
            
            switch random.nextIntMaxValue(maxValue: 4)
            {
            case 0:
                displayMessage(message: "???: Is someone there?")
                break
            case 1:
                displayMessage(message: "???: Help!")
                break
            case 2:
                displayMessage(message: "???: Who's there?")
                break
            case 3:
                displayMessage(message: "???: Can you help me?")
                break
            default:
                break
            }
            break
        }
        
        let skeleton = ACSkeleton()
        self.beginComponent(component: skeleton)
        
        let physiology = ACPhysiology()
        self.beginComponent(component: physiology)
        
        setupMesh()
        setupTexture()
        
        super.setup()
    }
    
    func setupMesh() {
        var iBone = 0
        
        let skeleton = ACSkeleton.GetComponent(entity: self) as! ACSkeleton
        skeleton.bonePositions.append(TDVector3Make(0.0, 0.0, 0.0)) //TODO: Remove these
        skeleton.boneRotations.append(TDQuaternionMakeWithAngleAndVector3Axis(0.2, TDVector3Make(0.0, 1.0, 0.0)))
        
        let masterClayMesh = ClayMesh()
        
        while iBone < skeleton.bonePositions.count
        {
            let clayMesh = ClayGeometry.createUVSphere(latitudeLines: 3, longitudeLines: 3, radius: 0.2)//ClayBox.makeBox(xCenter: 0.0, yCenter: 1.5, zCenter: 0.0, xLength: 0.5, yLength: 0.5, zLength: 0.5).getClayMesh(detail: 2)
            
            for vertex in clayMesh.vertices
            {
                vertex.normal = TDVector3Make(0.0, 1.0, 0.0)
                vertex.boneIndices = (index0: iBone, index1: 0, index2: 0, index3: 0)
                vertex.boneWeights = TDVector4Make(1.0, 0.0, 0.0, 0.0)
            }
            
            masterClayMesh.addMeshToMesh(mesh: clayMesh)
            
            iBone += 1
        }
        
        assert(masterClayMesh.vertices.count > 0, "Human vertex count is 0")
        mesh = masterClayMesh.getMeshVertexPosNorTexBone(renderer: getRenderer())
    }
    
    func setupTexture()
    {
        texture = RETexture.init(clayImage: ClayImage.init(red: getRandomMicro().nextFloatUnit(), green: getRandomMicro().nextFloatUnit(), blue: getRandomMicro().nextFloatUnit(), alpha: 1.0), renderer: getRenderer(), mipmapped: false)
        
    }
    
    override func getInteractions() -> Set<InteractionTypesEntity>? {
        
        return interactionsToGive
    }
}
