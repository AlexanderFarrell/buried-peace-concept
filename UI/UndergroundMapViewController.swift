//
//  UndergroundMapViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/30/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class UndergroundMapViewController: UIViewController {
    
    let sizeOfTile = 60.0
    let sizeOfPlayerIndicator = 20.0
    let borderSize = 4.0
    
    @IBOutlet var locationReadoutOutlet: UILabel!
    @IBOutlet var tileInfoOutlet: UILabel!
    var macroWorld: MacroWorld!
    var tileIndices = [UndergroundTile]()
    
    var gameplayVCDelegate: MapToGameplayDelegate!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentTile = macroWorld.getCurrentTile()
        
        let xCenter = currentTile!.x
        let yCenter = currentTile!.y
        locationReadoutOutlet.text = "You are at longitude: " + String(xCenter) + " and latitude: " + String(yCenter)
        
        //let button = getUIForTile(tile: currentTile!, xCenter: xCenter, yCenter: yCenter)
        
        var counter = 0
        
        let playerView = getUIForPlayerLocation(xCenter: xCenter, yCenter: yCenter)
        
        scrollView.addSubview(playerView)
        
        for knownTile in macroWorld.underground.knownTiles
        {
            let button = getUIForTile(tile: knownTile, xCenter: xCenter, yCenter: yCenter)
            
            tileIndices.append(knownTile)
            
            
            button.tag = counter
            button.addTarget(self, action: #selector(pressTile(sender:)), for: UIControlEvents.touchUpInside)
            
            counter += 1
            
            scrollView.addSubview(button)
        }
        
        scrollView.bringSubview(toFront: playerView)
        

        // Do any additional setup after loading the view.
    }
    
    func getUIForTile(tile: UndergroundTile, xCenter: Int, yCenter: Int) -> UIButton
    {
        let middleOffsetX = Double(self.view.bounds.width/2.0)
        let middleOffsetY = Double(self.view.bounds.height/2.0)
        
        let x = middleOffsetX + (Double(tile.x - xCenter) * (sizeOfTile + borderSize))
        let y = middleOffsetY + (Double(tile.y - yCenter) * (sizeOfTile + borderSize))
        
        let retValButton = UIButton.init(frame: CGRect.init(x: x, y: y, width: sizeOfTile, height: sizeOfTile))
        
        switch tile.tileType {
        case .HumanEncampment:
            retValButton.backgroundColor = UIColor.green
            break
        case .Instance:
            if tile.instanceDungeon!.cleared
            {
                retValButton.backgroundColor = UIColor.gray
            }
            else
            {
                retValButton.backgroundColor = UIColor.red
            }
            break
        case .Unsettled:
            retValButton.backgroundColor = UIColor.cyan
            break
        }
        
        return retValButton
    }
    
    func getUIForPlayerLocation(xCenter: Int, yCenter: Int) -> UIView
    {
        let middleOffsetX = Double(self.view.bounds.width/2.0)
        let middleOffsetY = Double(self.view.bounds.height/2.0)
        
        let x = middleOffsetX - (sizeOfPlayerIndicator/2.0) + (sizeOfTile/2.0)
        let y = middleOffsetY - (sizeOfPlayerIndicator/2.0) + (sizeOfTile/2.0)
        
        let retValView = UIView.init(frame: CGRect.init(x: x, y: y, width: sizeOfPlayerIndicator, height: sizeOfPlayerIndicator))
        
        retValView.backgroundColor = UIColor.orange
        
        return retValView
    }
    
    @objc func pressTile(sender: UIButton)
    {
        let indexOfTile = sender.tag
        
        assert((indexOfTile > -1) && (indexOfTile < tileIndices.count))
        
        let selectedTile = tileIndices[indexOfTile]
        
        locationReadoutOutlet.text = "Tile at longitude: " + String(selectedTile.x) + " and latitude: " + String(selectedTile.y)
        
        switch selectedTile.tileType {
        case .HumanEncampment:
            tileInfoOutlet.text = selectedTile.encampment!.name + "; Human Encampment; Population: " + String(selectedTile.encampment!.population)
            tileInfoOutlet.textColor = UIColor.green
            break
        case .Instance:
            if selectedTile.instanceDungeon!.cleared
            {
                tileInfoOutlet.text = selectedTile.instanceDungeon!.name + "; Cleared Instance. Defeated " + selectedTile.instanceDungeon!.bossName.capitalized + "."
                tileInfoOutlet.textColor = UIColor.gray
            }
            else
            {
                tileInfoOutlet.text = selectedTile.instanceDungeon!.name + "; Active Hostile Instance; "  + selectedTile.instanceDungeon!.bossName.capitalized + " dwells here."
                tileInfoOutlet.textColor = UIColor.red
            }
            break
        case .Unsettled:
            tileInfoOutlet.text = "Unsettled Passageway; Hostile Enemies: " + String(selectedTile.unsettledArea!.monsterCount)
            tileInfoOutlet.textColor = UIColor.cyan
            break
        }
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
