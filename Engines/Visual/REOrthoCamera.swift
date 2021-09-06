//
//  REOrthoCamera.swift
//  SpelunkingSwift
//
//  Created by Alexander Farrell on 5/13/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class REOrthoCamera: NSObject {
    //MARK: - Transformation Matrices
    private(set) public var ViewMatrix:       TDMatrix4!
    private(set) public var ProjectionMatrix: TDMatrix4!
    
    //MARK: - Projection Matrix Parameters
    private(set) public var CameraFrustumBounds: CGRect!
    public              var ZoomAmount: CGFloat!
    
    public var NearPlaneDistance:  Float = 1.0
    public var FarPlaneDistance:   Float = 100.0
    
    //MARK: - Initializer
    
    override init() {
        ViewMatrix = TDMatrix4Identity
        ProjectionMatrix = TDMatrix4Identity
        CameraFrustumBounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        ZoomAmount = 1;
        
        super.init()
    }
    
    //MARK: - Update
    
    func UpdateCamera(view: UIView, centerOfView: CGPoint) {
        CameraFrustumBounds.origin.x = centerOfView.x;
        CameraFrustumBounds.origin.y = centerOfView.y;
        CameraFrustumBounds.size.width = (view.bounds.size.width * ZoomAmount)
        CameraFrustumBounds.size.height = (view.bounds.size.height * ZoomAmount)
        
        UpdateViewMatrix()
        UpdateProjectionMatrix()
    }
    
    private func UpdateViewMatrix()
    {
        ViewMatrix = TDMatrix4MakeTranslation(Float(CameraFrustumBounds.origin.x), Float(CameraFrustumBounds.origin.y), 0.0)
    }
    
    private func UpdateProjectionMatrix()
    {
        ProjectionMatrix = TDMatrix4MakeWithRows(TDVector4Make(Float(1.0/CameraFrustumBounds.width), 0.0, 0.0, 0.0), TDVector4Make(0.0, -Float(1.0/CameraFrustumBounds.height), 0.0, 0.0), TDVector4Make(0.0, 0.0, 1.0, 0.0), TDVector4Make(0.0, 0.0, 0.0, 1.0))
    }
}
