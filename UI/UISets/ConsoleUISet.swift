//
//  ConsoleUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ConsoleUISet: UISet {
    var consoleView: ConsoleView!
    
    override init(parent: UIViewController) {
        super.init(parent: parent)
    }
    
    override func placeUI() {
        let xConsole = 20.0
        let yConsole = 60.0
        let consoleWidth = (Double(parentViewController.view.bounds.width) * 0.62) - xConsole
        let consoleHeight = (Double(parentViewController.view.bounds.height) * 0.5) - (yConsole * 1.5)
        
        let textContainer = NSTextContainer.init(size: CGSize.init(width: consoleWidth, height: consoleHeight))
        textContainer.maximumNumberOfLines = 7
        
        consoleView = ConsoleView.init(frame: CGRect.init(x: xConsole, y: yConsole, width: consoleWidth, height: consoleHeight), textContainer: nil) 
        consoleView.textColor = UIColor.white
        consoleView.isEditable = false
        
        consoleView.font = UIFont.systemFont(ofSize: CGFloat(15.0))
        //consoleView.
        
        addView(view: consoleView)
        
        enableUI(enableChildren: true)
    }
    
    override func refreshUILocations() {
        
    }
    
    override func breakdownUI() {
        consoleView.removeFromSuperview()
        consoleView.breakdown()
        consoleView.text = nil
        consoleView = nil
    }
}
