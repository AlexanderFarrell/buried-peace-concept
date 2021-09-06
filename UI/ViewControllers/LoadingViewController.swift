//
//  LoadingViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol LVCDelegate
{
    func returnToMenu()
}

class LoadingViewController: UIViewController, LVCDelegate {
    
    var gameplayViewController: GameplayViewController!
    var shouldReturnToMenu: Bool = false
    
    var legend: LegendGame!
    var savedGame: SavedGame?
    
    override var prefersStatusBarHidden: Bool{
        get {
            return true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if shouldReturnToMenu
        {
            self.dismiss(animated: false, completion: nil)
        }
        else
        {
            gameplayViewController = (self.storyboard?.instantiateViewController(withIdentifier: "GameplayVC") as! GameplayViewController)
            gameplayViewController.lvcDelegate = self
            
            gameplayViewController.legend = legend
            gameplayViewController.savedGame = savedGame
            
            gameplayViewController.startGameplay()
            
            self.present(gameplayViewController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func returnToMenu() {
        shouldReturnToMenu = true
    }
}
