//
//  StartLegendViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/17/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class StartLegendViewController: UIViewController, LegendSaveDataSource {
    var mainMenuDelegate: MainMenuDelegate!
    
    @IBOutlet var FileButtonOutlet: UIButton!
    @IBOutlet var selectorView: CollectionSelectorView!
    
    var legendGames = [LegendGame]()
    var files = [URL]()
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    override func viewDidLoad() {
        
        selectorView.legendSaveDataSource = self
    FileButtonOutlet.setImage(FileButtonOutlet.image(for: .normal)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
        
        FileButtonOutlet.imageView!.tintColor = UIColor.init(red: CGFloat(0.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0))
        
        loadLegends()
        
        resetSelectedLegendDisplay()
        
        super.viewDidLoad()
    }
    
    func loadLegends()
    {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("Legends")
        
        let fileManager = FileManager.default
        
        legendGames.removeAll()
        
        var legendsLoaded = [LegendGame]()
        files = [URL]()
        
        do {
            files = try fileManager.contentsOfDirectory(at: archiveURL, includingPropertiesForKeys: nil, options: [])
            print(files)
            
        } catch {
            print("Could get a list of directories for the legends")
        }
        
        var iFile = 0
        
        while iFile < files.count
        {
            do {
                let legendGame = try LegendGame.init(url: files[iFile])
                
                do {
                    try legendGame.loadHeader()
                } catch {
                    print("Failed to load header")
                    
                    do {
                        try legendGame.saveHeader()
                    } catch {
                        print("Needs work. Couldn't save this new header. File corrupted")
                    }
                }
                
                legendsLoaded.append(legendGame)
            } catch {
                print("Legend failed to decode from a json")
            }
            
            iFile += 1
        }
        
        legendGames = legendsLoaded
        
        self.selectorView.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectorView.collectionView.contentSize = selectorView.bounds.size
        
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.dismiss(animated: false, completion: {self.mainMenuDelegate.clearViewControllers()})
    }
    
    func resetSelectedLegendDisplay()
    {
        
    }
    
    func populateUI(cell: UICollectionViewCell, index: Int) -> UICollectionViewCell {
        (cell as! CollectionButtonViewCell).button!.setTitle(legendGames[index].header.name, for: .normal)
        
        return cell
    }
    
    func getNumberOfItems() -> Int {
        return legendGames.count
    }
    
    func userPressedIndex(index: Int) {
        let legendViewController = self.storyboard!.instantiateViewController(withIdentifier: "StartLegendConfirmViewController") as! StartLegendConfirmViewController
        legendViewController.legend = legendGames[index]
        self.present(legendViewController, animated: false, completion: nil)
    }
}
