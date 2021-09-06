//
//  BPWindow.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

import UIKit

protocol BPWindowDelegate {
    func closeWindow()
}

class BPWindow: UIView {
    var wpWindowDelegate: BPWindowDelegate!
    private var titleLabel: UILabel!
    private var closeButton: UIButton!
    private(set) public var bodyView: UIView!
    
    var bodyFrame: CGRect
    {
        get {
            return self.bodyView.frame
        }
    }
    
    init?(frame: CGRect, titleIn: String, delegate: BPWindowDelegate) {
        if (Double(frame.width) < Constants.minimumWPWindowWidth) || (Double(frame.height) < Constants.topRibbonWindowHeight)
        {
            print("Could not initialize the '" + titleIn + "' window correctly.")
            
            if (Double(frame.width) < Constants.minimumWPWindowWidth)
            {
                print("The width of " +  String(Double(frame.width)) + " is smaller than the minimum required width for a Buried Peace Window, which is " + String(Constants.minimumWPWindowWidth))
            }
            
            if (Double(frame.height) < Constants.topRibbonWindowHeight)
            {
                print("The height of " + String(Double(frame.height)) + " is smaller than the minimum required height for a Buried Peace Window, which is " + String(Constants.topRibbonWindowHeight))
            }
            
            return nil
        }
        else
        {
            super.init(frame: frame)
            
            self.backgroundColor = Constants.WindowBorderColor
            
            bodyView = UIView.init(frame: CGRect.init(x: 2.0, y: Constants.topRibbonWindowHeight, width: Double(self.frame.width) - Constants.wpWindowBorderSize, height: Double(self.frame.height) - (Constants.wpWindowBorderSize * 2.0) - Constants.topRibbonWindowHeight))
            bodyView.backgroundColor = Constants.WindowBodyColor
            
            self.addSubview(bodyView)
            
            wpWindowDelegate = delegate
            
            titleLabel = UILabel.init(frame: CGRect.init(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(Float(self.frame.width) - Float(Constants.topRibbonWindowHeight)), height: CGFloat(Constants.topRibbonWindowHeight)))
            titleLabel.text = titleIn
            titleLabel.font = UIFont.systemFont(ofSize: CGFloat(Constants.topRibbonWindowHeight - (Constants.wpWindowBorderSize * 2.0)))
            titleLabel.textColor = UIColor.white//Constants.NormalUIColor
            
            addSubview(titleLabel)
            
            closeButton = UIButton.init(frame: CGRect.init(x: CGFloat(Float(self.frame.width) - Float(Constants.topRibbonWindowHeight)), y: CGFloat(0.0), width: CGFloat(Constants.topRibbonWindowHeight), height: CGFloat(Constants.topRibbonWindowHeight)))
            closeButton.setTitle("X", for: UIControlState.normal)
            closeButton.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(Constants.topRibbonWindowHeight - (Constants.wpWindowBorderSize * 2.0)))
            closeButton.setTitleColor(Constants.DestructiveUIColor, for: UIControlState.normal)
            closeButton.addTarget(self, action: #selector(closeButtonPress), for: UIControlEvents.touchUpInside)
            
            addSubview(closeButton)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("Cannot initialize a WPWindow from an NSCoder")
        
        return nil
        
        //fatalError("init(coder:) has not been implemented")
    }
    
    var title: String
    {
        get {
            return titleLabel.text!
        }
        
        set {
            titleLabel.text = newValue
        }
    }
    
    @objc func closeButtonPress()
    {
        wpWindowDelegate.closeWindow()
    }
    
}
