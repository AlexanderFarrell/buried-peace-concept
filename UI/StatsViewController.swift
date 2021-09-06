//
//  StatsViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/30/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    @IBOutlet var textOutput: UITextView!
    var macroWorld: MacroWorld!
    var gameplayVCDelegate: MapToGameplayDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var outputString = ""
        
        outputString = outputString + "Discovered Settlements: " + String(macroWorld.underground.knownEncampments.count) + "\n"
        
        
        var humans = 0
        
        for encampment in macroWorld.underground.knownEncampments
        {
            humans += encampment.population
        }
        
        outputString = outputString + "Known Survivors: " + String(humans) + "\n" + "\n"
        
        outputString = outputString + "Discovered Instances: " + String(macroWorld.underground.knownInstanceDungeons.count) + "\n"
        
        var clearedInstances = 0
        
        for instance in macroWorld.underground.knownInstanceDungeons
        {
            if instance.cleared
            {
                clearedInstances += 1
            }
        }
        
        outputString = outputString + "Cleared Instances: " + String(clearedInstances) + "\n"
        outputString = outputString + "Active Hostile Instances: " + String(macroWorld.underground.knownInstanceDungeons.count - clearedInstances) + "\n" + "\n"
        
        outputString = outputString + "Total Discovered Sections of the Underground: " + String(macroWorld.underground.knownTiles.count) + "\n" + "\n"
        
        outputString = outputString + "Current Level of Depth: " + String(macroWorld.underground.playerLocationLayer) + "\n"
        outputString = outputString + "Latitude: " + String(macroWorld.underground.playerLocationX) + "\n"
        outputString = outputString + "Longitude: " + String(macroWorld.underground.playerLocationY) + "\n"
        
        textOutput.text = outputString
        
        /*for knownTile in macroWorld.underground.knownTiles
        {
            let button = getUIForTile(tile: knownTile, xCenter: xCenter, yCenter: yCenter)
            
            tileIndices.append(knownTile)
            
            
            button.tag = counter
            button.addTarget(self, action: #selector(pressTile(sender:)), for: UIControlEvents.touchUpInside)
            
            counter += 1
            
            scrollView.addSubview(button)
            switch tile.tileType {
            case .HumanEncampment:
                retValButton.backgroundColor = UIColor.green
                break
            case .Instance:
                retValButton.backgroundColor = UIColor.red
                break
            case .Unsettled:
                retValButton.backgroundColor = UIColor.cyan
                break
        }*/

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPress(_ sender: UIButton) {
        gameplayVCDelegate.unpauseGame()
        
        self.dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
