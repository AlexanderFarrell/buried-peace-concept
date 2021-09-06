//
//  PauseUISet.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/2/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class PauseUISet: UISet {
    var ResumeButton: UIButton!
    var OptionsButton: UIButton!
    var QuitButton: UIButton!
    var pauseLabel: UILabel!
    
    var gameplayUISetDelegate: GameplayUISetDelegate!
    
    override init(parent: UIViewController) {
        super.init(parent: parent)
    }
    
    override func placeUI()
    {
        setupPauseLabel()
        
        setupResumeButton()
        setupOptionsButton()
        setupQuitButton()
        //Z Pattern the Buttons?
        
        super.placeUI()
        
        enableUI(enableChildren: true)
    }
    
    private func setupPauseLabel()
    {
        let xLabel = CGFloat(50.0)
        let yLabel = CGFloat(20.0)
        
        let widthLabel = CGFloat(parentViewController.view.bounds.width/2.0)
        let heightLabel = CGFloat(Float(self.parentViewController.view.bounds.height) * 0.18)
        
        let fontSize = CGFloat((Int(heightLabel)/2) - 3)
        
        pauseLabel = UILabel.init(frame: CGRect.init(x: xLabel, y: yLabel, width: widthLabel, height: heightLabel))
        //pauseLabel.text = "Game Paused"
        
        pauseLabel.attributedText = UISet.getShadowedAttributedString(string: "Game Paused", textColor: Constants.NormalUIColor, shadowColor: Constants.ShadowUIColor)
        pauseLabel.textColor = Constants.NormalUIColor
        pauseLabel.font = makeFont(size: fontSize)
        
        addView(view: pauseLabel)
    }
    
    private func setupResumeButton()
    {
        let widthButton = CGFloat(200.0)
        let heightButton = CGFloat(Float(self.parentViewController.view.bounds.height) * 0.15)
        let xButton = CGFloat((Float(self.parentViewController.view.bounds.width) * 0.9) - Float(widthButton))
        let yButton = CGFloat(Float(self.parentViewController.view.bounds.height) * 0.3)
        
        let fontSize = CGFloat((Int(heightButton)/2) - 3)
        
        ResumeButton = UIButton.init(frame: CGRect.init(x: xButton, y: yButton, width: widthButton, height: heightButton))
        //ResumeButton.backgroundColor = UIColor.white
        ResumeButton.setAttributedTitle(UISet.getShadowedAttributedString(string: "Resume", textColor: Constants.NormalUIColor, shadowColor: Constants.ShadowUIColor), for: .normal)
        ResumeButton.setTitleColor(Constants.NormalUIColor, for: .normal)
        ResumeButton.titleLabel?.font = makeFont(size: fontSize)
        ResumeButton.addTarget(self, action: #selector(ResumeButtonPress), for: UIControlEvents.touchUpInside)
        ResumeButton.setTitleShadowColor(Constants.InactiveUIColor, for: .normal)
        
        addView(view: ResumeButton)
    }
    
    private func setupOptionsButton()
    {
        let widthButton = CGFloat(200.0)
        let heightButton = CGFloat(Float(self.parentViewController.view.bounds.height) * 0.15)
        let xButton = CGFloat((Float(self.parentViewController.view.bounds.width) * 0.9) - Float(widthButton))
        let yButton = CGFloat(Float(self.parentViewController.view.bounds.height) * 0.5)
        
        let fontSize = CGFloat((Int(heightButton)/2) - 3)
        
        OptionsButton = UIButton.init(frame: CGRect.init(x: xButton, y: yButton, width: widthButton, height: heightButton))
        //OptionsButton.backgroundColor = UIColor.white
        OptionsButton.setAttributedTitle(UISet.getShadowedAttributedString(string: "Options", textColor: Constants.NormalUIColor, shadowColor: Constants.ShadowUIColor), for: .normal)
        OptionsButton.setTitleColor(Constants.NormalUIColor, for: .normal)
        OptionsButton.titleLabel?.font = makeFont(size: fontSize)
        OptionsButton.addTarget(self, action: #selector(OptionsButtonPress), for: UIControlEvents.touchUpInside)
        OptionsButton.setTitleShadowColor(Constants.InactiveUIColor, for: .normal)
        
        addView(view: OptionsButton)
    }
    
    private func setupQuitButton()
    {
        let widthButton = CGFloat(200.0)
        let heightButton = CGFloat(Float(self.parentViewController.view.bounds.height) * 0.15)
        let xButton = CGFloat((Float(self.parentViewController.view.bounds.width) * 0.9) - Float(widthButton))
        let yButton = CGFloat(Float(self.parentViewController.view.bounds.height) * 0.7)
        
        let fontSize = CGFloat((Int(heightButton)/2) - 3)
        
        QuitButton = UIButton.init(frame: CGRect.init(x: xButton, y: yButton, width: widthButton, height: heightButton))
        //QuitButton.backgroundColor = UIColor.white
        QuitButton.setAttributedTitle(UISet.getShadowedAttributedString(string: "Quit", textColor: Constants.DestructiveUIColor, shadowColor: Constants.ShadowUIColor), for: .normal)
        //QuitButton.setTitleColor(Constants.DestructiveUIColor, for: .normal)
        QuitButton.titleLabel?.font = makeFont(size: fontSize)
        QuitButton.addTarget(self, action: #selector(QuitButtonPress), for: UIControlEvents.touchUpInside)
        QuitButton.setTitleShadowColor(Constants.InactiveUIColor, for: .normal)
        
        addView(view: QuitButton)
    }
    
    @objc func ResumeButtonPress()
    {
        self.gameplayUISetDelegate.ClosePauseMenu()
    }
    
    @objc func QuitButtonPress()
    {
        self.gameplayUISetDelegate.EndGameplay()
    }
    
    @objc func OptionsButtonPress()
    {
        
    }
    
    private func makeFont(size: CGFloat) -> UIFont
    {
        return UIFont.systemFont(ofSize: size)
    }
    
    override func refreshUILocations()
    {
        super.refreshUILocations()
    }
    
    override func breakdownUI()
    {
        ResumeButton.removeTarget(nil, action: nil, for: UIControlEvents.allEvents)
        OptionsButton.removeTarget(nil, action: nil, for: UIControlEvents.allEvents)
        QuitButton.removeTarget(nil, action: nil, for: UIControlEvents.allEvents)
        
        ResumeButton = nil
        OptionsButton = nil
        QuitButton = nil
        
        super.breakdownUI()
    }
}
