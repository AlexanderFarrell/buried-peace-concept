//
//  RECamera.swift
//  SpelunkingSwift
//
//  Created by Alexander Farrell on 5/13/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

enum IntersectionTypeC {
    case Inside
    case Intersect
    case Outside
}

class RECamera: NSObject {
    //MARK: - Transformation Matrices
    private(set) public var ViewMatrix:       TDMatrix4!
    private(set) public var ProjectionMatrix: TDMatrix4!
    
    //MARK: - View Matrix Parameters
    public var CameraPosition: TDVector3!
    public var CameraTarget:   TDVector3!
    public var CameraUp:       TDVector3!
    
    //MARK: - Projection Matrix Parameters
    public var FieldOfViewRadians: Float = 1.0
    public var AspectRatio:        Float = 1.0
    public var NearPlaneDistance:  Float = 1.0
    public var FarPlaneDistance:   Float = 10.0
    private(set) public var widthNearPlane: Float = 0.0
    private(set) public var heightNearPlane: Float = 0.0
    
    private(set) public var cameraReferentialX: TDVector3 = TDVector3Make(0, 0, 0)
    private(set) public var cameraReferentialY: TDVector3 = TDVector3Make(0, 0, 0)
    private(set) public var cameraReferentialZ: TDVector3 = TDVector3Make(0, 0, 0)
    private(set) public var cameraReferentialTangent: Float = 0.0
    
    private(set) public var sphereFactorX: Float = 0.0
    private(set) public var sphereFactorY: Float = 0.0
    
    //MARK: - Initializer
    
    func UpdateCamera(view: UIView) {
        UpdateViewMatrix(view: view)
        UpdateProjectionMatrix(view: view)
    }
    
    //MARK: - Update
    
    func UpdateCameraPositionToChase(x: Float!, y: Float!, z: Float!, targetLift: Float!, yaw: Float!, pitch: Float!, distance: Float!)
    {
        CameraTarget = TDVector3Make(x, y + targetLift, z)
        
        //Calculate Position
        var chaseVector = TDVector3Make(0, 0, -distance)
        chaseVector = TDMatrix4MultiplyVector3(TDMatrix4MakeXRotation(-pitch), chaseVector)
        chaseVector = TDMatrix4MultiplyVector3(TDMatrix4MakeYRotation(yaw), chaseVector)
        chaseVector = TDVector3Add(CameraTarget, chaseVector)
        
        CameraPosition = chaseVector
    }
    func UpdateCameraPositionFirstPerson(xPos: Float, yPos: Float, zPos: Float, yaw: Float, pitch: Float, cameraLift: Float)
    {
        CameraPosition = TDVector3Make(xPos, yPos + cameraLift, zPos)
        CameraUp = TDVector3Make(0, 1, 0)
        
        //Calculate Position
        var targetVector = TDVector3Make(0, 0, 1)
        targetVector = TDMatrix4MultiplyVector3(TDMatrix4MakeXRotation(-pitch), targetVector)
        targetVector = TDMatrix4MultiplyVector3(TDMatrix4MakeYRotation(yaw), targetVector)
        targetVector = TDVector3Add(CameraPosition, targetVector)
        
        CameraTarget = targetVector
    }
    
    private func UpdateViewMatrix(view: UIView) {
        ViewMatrix = TDMatrix4MakeLookAt(CameraPosition.v.0, CameraPosition.v.1, CameraPosition.v.2,
                                         CameraTarget.v.0, CameraTarget.v.1, CameraTarget.v.2,
                                         CameraUp.v.0, CameraUp.v.1, CameraUp.v.2)
        
        cameraReferentialZ = TDVector3Subtract(CameraTarget, CameraPosition)
        cameraReferentialZ = TDVector3Normalize(cameraReferentialZ)
        
        cameraReferentialX = TDVector3Multiply(cameraReferentialZ, CameraUp)
        
    }
    
    private func UpdateProjectionMatrix(view: UIView) {
        AspectRatio = (Float(view.bounds.size.width / view.bounds.size.height))
        
        ProjectionMatrix = TDMatrix4MakePerspective(FieldOfViewRadians, AspectRatio, NearPlaneDistance, FarPlaneDistance)
        
        
        //Pre Calculate these anytime the projection matrix changes, it doesnt need to be calculated over and over again. In fact the projection matrix doesnt need to be either.
        let halfFieldOfView = FieldOfViewRadians * 0.5
        cameraReferentialTangent = tanf(halfFieldOfView)
        sphereFactorY = 1.0/cosf(halfFieldOfView)
        
        let fieldOfViewX = atanf(cameraReferentialTangent * AspectRatio)
        sphereFactorX = 1.0/cosf(fieldOfViewX)
        
        heightNearPlane = NearPlaneDistance * cameraReferentialTangent
        widthNearPlane = heightNearPlane * AspectRatio
    }
    
    func SetFieldOfViewInDegrees(degrees: Float) {
        FieldOfViewRadians = TDMathDegreesToRadians(degrees)
    }
    
    func isPointInFrustum(point: TDVector3) -> Bool
    {
        var returnValue = true
        
        var pcz, pcx, pcy, aux: Float
        
        let vector = TDVector3Subtract(point, CameraPosition)
        
        pcz = TDVector3DotProduct(vector, cameraReferentialZ)
        if ((pcz > FarPlaneDistance) || (pcz < NearPlaneDistance))
        {
            returnValue = false
            return returnValue
        }
        
        pcy = TDVector3DotProduct(vector, cameraReferentialY)
        aux = pcz * cameraReferentialTangent
        if ((pcy > aux) || (pcy < -aux))
        {
            returnValue = false
            return returnValue
        }
        
        pcx = TDVector3DotProduct(vector, cameraReferentialZ)
        aux = aux * AspectRatio
        if ((pcx > aux) || (pcx < -aux))
        {
            returnValue = false
            return returnValue
        }
        
        return returnValue
    }
    
    func isPointInFrustum(point: TDVector3, drawDistance: Float) -> Bool
    {
        var returnValue = true
        
        let distance = TDVector3Distance(point, CameraPosition)
        
        if distance > drawDistance
        {
            returnValue = false
        }
        else
        {
            returnValue = self.isPointInFrustum(point: point)
        }
        
        return returnValue
    }
    
    /*
     
     - (IntersectionType)isSphereInFrustum:(BoundingSphere *)sphere
     {
     IntersectionType returnValue = Inside;
     
     float d;
     float ax, ay, az;
     
     GLKVector3 vector = GLKVector3Subtract(sphere.center, _cameraPosition);
     
     //Test Z
     az = GLKVector3DotProduct(vector, _cameraReferentialZ);
     if ((az > (_farPlaneDistance + sphere.radius))|(az < (_nearPlaneDistance - sphere.radius))) {
     returnValue = Outside;
     return returnValue;
     }
     
     if ((az > (_farPlaneDistance - sphere.radius))|(az < (_nearPlaneDistance + sphere.radius))) {
     returnValue = Intersect;
     }
     
     //Test Y
     ay = GLKVector3DotProduct(vector, _cameraReferentialY);
     d = _sphereFactorY * sphere.radius;
     az *= _cameraReferentialTangent;
     if ((ay > (az+d))|(ay < (-az-d))) {
     returnValue = Outside;
     return returnValue;
     }
     
     if ((ay > (az-d))|(ay < (-az+d))) {
     returnValue = Intersect;
     }
     
     //Test X
     ax = GLKVector3DotProduct(vector, _cameraReferentialX);
     az *= _aspectRatio;
     d = _sphereFactorX * sphere.radius;
     if ((ax > (az+d))|(ax < (-az-d))) {
     returnValue = Outside;
     return returnValue;
     }
     
     if ((ax > (az-d))|(ax < (-az+d))) {
     returnValue = Intersect;
     }
     
     return returnValue;
     }
 */
}
