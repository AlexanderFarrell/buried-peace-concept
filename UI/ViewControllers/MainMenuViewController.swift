//
//  MainMenuViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 10/26/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol MainMenuDelegate {
    func clearViewControllers()
}

class MainMenuViewController: UIViewController, MainMenuDelegate {
    var startLegendVC: StartLegendViewController?
    var loadLegendVC: LoadLegendViewController?
    var optionsVC: OptionsViewController?
    var legendManagerVC: LegendManagerViewController?
    
    override func viewDidLoad() {
        let userDefaults = UserDefaults.standard
        
        if !(userDefaults.bool(forKey: "RanFirstTimeOperation") == true)
        {
            firstTimeRun()
        }
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool{
        get {
            return true
        }
    }
    
    func firstTimeRun()
    {
        UserDefaults.standard.set(true, forKey: "RanFirstTimeOperation")
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        createDirectory(nameOfDirectory: "Legends")
        createDirectory(nameOfDirectory: "SavedGames")
    }
    
    private func createDirectory(nameOfDirectory: String)
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let dataPath = path.appendingPathComponent(nameOfDirectory)
        
        do {
            //TODO: Make URL Based
            try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            print("Created Directory: " + nameOfDirectory)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)" + nameOfDirectory)
        }
    }
    
    @IBAction func startLegendButtonPress(_ sender: Any) {
        startLegendVC = (self.storyboard!.instantiateViewController(withIdentifier: "StartLegendViewController") as! StartLegendViewController)
        startLegendVC!.mainMenuDelegate = self
        self.present(startLegendVC!, animated: false, completion: nil)
    }
    
    @IBAction func loadLegendButtonPress(_ sender: Any) {
        loadLegendVC = (self.storyboard!.instantiateViewController(withIdentifier: "LoadLegendViewController") as! LoadLegendViewController)
        loadLegendVC!.mainMenuDelegate = self
        self.present(loadLegendVC!, animated: false, completion: nil)
    }
    
    @IBAction func optionsButtonPress(_ sender: Any) {
        optionsVC = (self.storyboard!.instantiateViewController(withIdentifier: "OptionsViewController") as! OptionsViewController)
        optionsVC!.mainMenuDelegate = self
        self.present(optionsVC!, animated: false, completion: nil)
    }
    
    @IBAction func editorButtonPress(_ sender: Any) {
        legendManagerVC = (self.storyboard!.instantiateViewController(withIdentifier: "LegendManagerViewController") as! LegendManagerViewController)
        legendManagerVC!.mainMenuDelegate = self
        self.present(legendManagerVC!, animated: false, completion: nil)
    }
    
    func clearViewControllers() {
        startLegendVC = nil
        loadLegendVC = nil
        optionsVC = nil
        legendManagerVC = nil
    }
}
