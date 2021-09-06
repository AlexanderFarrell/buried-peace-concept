//
//  ConsoleView.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class ConsoleView: UITextView {
    var finalText: String = ""
    var messages: [String] = [String]()
    var time: Int = 0
    let waitTime = 180
    let messageMaxCount = 7
    var timer: Timer!
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        
        super.init(frame: frame, textContainer: textContainer)
        timer = Timer.scheduledTimer(timeInterval: 1.0/60.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        self.backgroundColor = UIColor.init(white: CGFloat(0.0), alpha: CGFloat(0.0))
        
        self.isSelectable = false
        
        self.isUserInteractionEnabled = false
        
        //self.font = UIFont.init(name: "OpenDyslexic-Regular", size: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        timer = Timer.scheduledTimer(timeInterval: 1.0/60.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        //self.font = UIFont.init(name: "OpenDyslexic-Regular", size: 12)
    }
    
    func breakdown()
    {
        timer.invalidate()
    }
    
    func addMessage(string: String)
    {
        messages.append(string)
        
        if messages.count >= messageMaxCount
        {
            messages.removeFirst()
        }
        
        updateUI()
        
        time = waitTime
    }
    
    @objc func update()
    {
        if messages.count > 0
        {
            
            time -= 1
            
            if time < 1
            {
                time = waitTime
                messages.removeFirst()
                updateUI()
            }
        }
    }
    
    func updateUI()
    {
        finalText = ""
        
        if messages.count > 0
        {
            for index in 0...messages.count-1
            {
                finalText = finalText + messages[index] + "\n"
            }
        }
        
        self.attributedText = UISet.getShadowedAttributedString(string: finalText, textColor: Constants.NormalUIColor, shadowColor: Constants.ShadowUIColor, shadowBlurRadius: CGFloat(1.2), shadowOffset: CGSize.init(width: 1, height: 1)) //UISet.getShadowedAttributedString(string: finalText, textColor: Constants.NormalUIColor, shadowColor: Constants.ShadowUIColor)//finalText
    }
}
