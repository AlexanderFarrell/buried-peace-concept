//
//  MapUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/25/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class MapUISet: UISet, BPWindowDelegate, UIScrollViewDelegate {
    
    let sizeOfTile = 30.0
    let sizeOfPlayerIndicator = 10.0
    let connectionLength = 15.0
    let borderSize = 10.0
    let labelHeight = 12.0
    
    var locationReadoutLabel: UILabel!
    var tileInfoLabel: UILabel!
    
    var scrollView: UIScrollView!
    
    var wpWindow: BPWindow!
    //var dashboardDelegate: DashboardUISetDelegate!
    var gameplayUIDelegate: GameplayUISetDelegate!
    
    //UI
    
    override init(parent: UIViewController) {
        super.init(parent: parent)
    }
    
    override func placeUI()
    {
        //Place the window
        let windowBorderSizeX = Double(parentViewController.view.frame.width) * Constants.ModalWindowDefaultScreenBorderSizePer
        let windowBorderSizeY = Double(parentViewController.view.frame.height) * Constants.ModalWindowDefaultScreenBorderSizePer
        
        wpWindow = BPWindow.init(frame: CGRect.init(x: windowBorderSizeX, y: windowBorderSizeY, width: Double(parentViewController.view.frame.width) - (windowBorderSizeX * 2.0), height: Double(parentViewController.view.frame.height) - (windowBorderSizeY * 2.0)), titleIn: "Map", delegate: self)
        
        addView(view: wpWindow)
        
        super.placeUI()
        
        setupMapViewUI()
        setupMap()
        
        self.showUI(showChildren: true)
        self.enableUI(enableChildren: true)
    }
    
    func setupMapViewUI()
    {
        scrollView = UIScrollView.init(frame: wpWindow.bodyView.bounds)
        scrollView.delegate = self
        scrollView.contentSize = CGSize.init(width: 4000, height: 4000)
        scrollView.contentOffset = CGPoint.init(x: 1000, y: 1000)
        scrollView.maximumZoomScale = CGFloat(8.0)
        scrollView.minimumZoomScale = CGFloat(0.25)
        
        locationReadoutLabel = UILabel.init(frame: CGRect.init(x: 0.0, y: Double(wpWindow.bodyFrame.height) - labelHeight, width: Double(wpWindow.bodyFrame.width), height: labelHeight))
        tileInfoLabel = UILabel.init(frame: CGRect.init(x: 0.0, y: 0.0, width: Double(wpWindow.bodyFrame.width), height: labelHeight))
        
        locationReadoutLabel.font = UIFont.systemFont(ofSize: CGFloat(labelHeight))
        locationReadoutLabel.textColor = Constants.NormalUIColor
        
        tileInfoLabel.font = UIFont.systemFont(ofSize: CGFloat(labelHeight))
        tileInfoLabel.textColor = Constants.NormalUIColor
        
        wpWindow.bodyView.addSubview(scrollView)
        wpWindow.bodyView.addSubview(locationReadoutLabel)
        wpWindow.bodyView.addSubview(tileInfoLabel)
    }
    
    /*func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView
    }*/
    
    func setupMap()
    {
        
    }
    
    func getUIForPlayerLocation(xCenter: Int, yCenter: Int) -> UIView
    {
        let middleOffsetX = Double(scrollView.bounds.width/2.0)
        let middleOffsetY = Double(scrollView.bounds.height/2.0)
        
        let x = middleOffsetX - (sizeOfPlayerIndicator/2.0) + (sizeOfTile/2.0) + 1000.0
        let y = middleOffsetY - (sizeOfPlayerIndicator/2.0) + (sizeOfTile/2.0) + 1000.0
        
        let retValView = UIView.init(frame: CGRect.init(x: x, y: y, width: sizeOfPlayerIndicator, height: sizeOfPlayerIndicator))
        
        retValView.backgroundColor = UIColor.orange
        
        return retValView
    }
    
    @objc func pressTile(sender: UIButton)
    {
        let indexOfTile = sender.tag
    }
    
    override func refreshUILocations()
    {
        super.refreshUILocations()
    }
    
    override func breakdownUI()
    {
        super.breakdownUI()
    }
    
    func closeWindow() {
        //dashboardDelegate.closeInventory()
        gameplayUIDelegate.CloseMapMenu()
    }
    
}
