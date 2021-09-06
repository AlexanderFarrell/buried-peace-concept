//
//  ACPhysiology.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/24/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol PhysiologyDelegate {
    func getEntityPosition() -> TDVector3
    func getEntityYaw() -> Float
    func getEntityPitch() -> Float
}

class ACPhysiology: AgentComponent, PhysiologyDelegate {
    
    var torso: Ligament?
    var head: Ligament?
    var leftHand: Ligament?
    var rightHand: Ligament?
    var leftFoot: Ligament?
    var rightFoot: Ligament?
    
    var dna: PhysiologicalDNA?
    var ligaments: [Ligament] = [Ligament]()
    
    //Tag Ligaments!
    
    override func begin() {
        //Make sure the ACSkeleton is installed onto the entity
        if let skeleton = ACSkeleton.GetComponent(entity: self.entityDelegate.getEntityHost()) as? ACSkeleton
        {
            /*if dna != nil
            {
                (self.entityDelegate.getEntityHost() as! DrawableEntity).mesh = createMesh(dna: dna!)
                createBones(dna: dna!, skeleton: skeleton)
            }
            else
            {
                self.entityDelegate.getEntityHost().endComponent(component: self)
            }*/
            
            torso = Ligament()
            torso!.delegate = self
            torso!.constrainedToParent = false
            torso!.positionLocal = TDVector3Make(0.0, 1.5, 0.0)
            torso!.typeLigament = .Body
            ligaments.append(torso!)
            
            head = Ligament()
            head!.delegate = self
            head!.constrainedToParent = true
            head!.maxDistanceToParent = 0.4
            head!.parentConnectedPosition = TDVector3Make(0.0, 0.1, 0.0)
            head!.parentLigament = torso!
            head!.positionLocal = TDVector3Make(0.0, 2.0, 0.0)
            head!.typeLigament = .Head
            ligaments.append(head!)
            
            leftHand = Ligament()
            leftHand!.delegate = self
            leftHand!.constrainedToParent = true
            leftHand!.maxDistanceToParent = 0.75
            leftHand!.parentConnectedPosition = TDVector3Make(-0.25, 0.0, 0.0)
            leftHand!.parentLigament = torso!
            leftHand!.positionLocal = TDVector3Make(-1.0, 1.5, 0.0)
            leftHand!.typeLigament = .Hand
            ligaments.append(leftHand!)
            
            rightHand = Ligament()
            rightHand!.delegate = self
            rightHand!.constrainedToParent = true
            rightHand!.maxDistanceToParent = 0.75
            rightHand!.parentConnectedPosition = TDVector3Make(0.25, 0.0, 0.0)
            rightHand!.parentLigament = torso!
            rightHand!.positionLocal = TDVector3Make(1.0, 1.5, 0.0)
            rightHand!.typeLigament = .Hand
            ligaments.append(rightHand!)
            
            leftFoot = Ligament()
            leftFoot!.delegate = self
            leftFoot!.constrainedToParent = true
            leftFoot!.maxDistanceToParent = 0.82
            leftFoot!.parentConnectedPosition = TDVector3Make(-0.25, -0.8, 0.0)
            leftFoot!.parentLigament = torso!
            leftFoot!.positionLocal = TDVector3Make(-0.25, 0.0, 0.0)
            leftFoot!.typeLigament = .Foot
            ligaments.append(leftFoot!)
            
            rightFoot = Ligament()
            rightFoot!.delegate = self
            rightFoot!.constrainedToParent = true
            rightFoot!.maxDistanceToParent = 0.82
            rightFoot!.parentConnectedPosition = TDVector3Make(0.25, -0.8, 0.0)
            rightFoot!.parentLigament = torso!
            rightFoot!.positionLocal = TDVector3Make(0.25, 0.0, 0.0)
            rightFoot!.typeLigament = .Foot
            ligaments.append(rightFoot!)
            
            var iLigament = 0
            
            while iLigament < ligaments.count
            {
                let ligament = ligaments[iLigament]
                iLigament += 1
                
                ligament.boneIndex = iLigament
                
                skeleton.bonePositions.append(ligament.positionLocal)
                skeleton.boneRotations.append(TDQuaternionMakeWithAngleAndAxis(0.0, 1.0, 0.0, 0.0))
            } /* TODO: Comment this out and rely on DNA */
        }
        else
        {
            self.entityDelegate.getEntityHost().endComponent(component: self)
        }
    }
    
    func createMesh(dna: PhysiologicalDNA) -> REMesh
    {
        var retValMesh: REMesh
        let masterClayMesh = ClayMesh()
        
        var iLigament = 0
        
        while iLigament < dna.ligaments.count
        {
            let mesh = dna.ligaments[iLigament].getMesh(boneIndex: iLigament)
            
            let iVertex = 0
            
            while iVertex < mesh.vertices.count
            {
                mesh.vertices[iVertex].boneIndices = (index0: iLigament, index1: 0, index2: 0, index3: 0)
                mesh.vertices[iVertex].boneWeights = TDVector4Make(1.0, 0.0, 0.0, 0.0)
            }
            
            masterClayMesh.addMeshToMesh(mesh: mesh)
            
            iLigament += 1
        }
        
        retValMesh = masterClayMesh.getMeshVertexPosNorTexBone(renderer: getRenderer())
        
        return retValMesh
    }
    
    func createBones(dna: PhysiologicalDNA, skeleton: ACSkeleton)
    {
        var iLigament = 0
        
        while iLigament < dna.ligaments.count
        {
            let dnaLigament = dna.ligaments[iLigament]
            let ligament = Ligament()
            ligament.delegate = self
            ligament.positionLocal = dnaLigament.startPosition
            ligament.typeLigament = dnaLigament.ligamentType
            
            /*
             
             rightFoot!.delegate = self
             rightFoot!.constrainedToParent = true
             rightFoot!.maxDistanceToParent = 0.82
             rightFoot!.parentConnectedPosition = TDVector3Make(0.25, -0.8, 0.0)
             rightFoot!.parentLigament = torso!
             rightFoot!.positionLocal = TDVector3Make(0.25, 0.0, 0.0)
             rightFoot!.typeLigament = .Foot
 */
            
            iLigament += 1
            
            ligament.boneIndex = iLigament
            ligaments.append(ligament)
            
            switch ligament.typeLigament
            {
            case .Body:
                break
            case .Foot:
                break
            case .Connector:
                break
            case .Hand:
                break
            case .Wing:
                break
            case .Tail:
                break
            case .Head:
                break
            }
            
            skeleton.bonePositions.append(ligament.positionLocal)
            skeleton.boneRotations.append(TDQuaternionMakeWithAngleAndAxis(0.0, 1.0, 0.0, 0.0))
        }
    }
    
    override func update() {
        let skeleton = ACSkeleton.GetComponent(entity: self.entityDelegate.getEntityHost()) as! ACSkeleton
        
        var iLigament = 0
        
        while iLigament < ligaments.count
        {
            let ligament = ligaments[iLigament]
            
            ligament.boneIndex = iLigament
            
            skeleton.bonePositions[iLigament] = ligament.positionLocal
            skeleton.boneRotations[iLigament] = TDQuaternionMakeWithAngleAndAxis(0.0, 1.0, 0.0, 0.0)
            iLigament += 1
        }
        
        super.update()
    }
    
    func getEntityPosition() -> TDVector3 {
        return self.entityDelegate.getEntityHost().Position()
    }
    
    func getEntityYaw() -> Float {
        return self.entityDelegate.getEntityHost().yaw
    }
    
    func getEntityPitch() -> Float {
        return self.entityDelegate.getEntityHost().pitch
    }
    
    override class func componentName() -> String {
        return "Physiology"
    }
}
