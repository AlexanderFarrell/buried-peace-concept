//
//  LegendManagerViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/17/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

protocol LMVCDelegate {
    func reloadData()
}

class LegendManagerViewController: UIViewController, LegendSaveDataSource, LMVCDelegate {
    
    @IBOutlet var FileButtonOutlet: UIButton!
    @IBOutlet var selectorView: CollectionSelectorView!
    var mainMenuDelegate: MainMenuDelegate!
    
    var legendGames = [LegendGame]()
    var files = [URL]()
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    override func viewDidLoad() {        
        super.viewDidLoad()
        FileButtonOutlet.setImage(FileButtonOutlet.image(for: .normal)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
        
        FileButtonOutlet.imageView!.tintColor = UIColor.init(red: CGFloat(0.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0))
        
        selectorView.legendSaveDataSource = self
        
        loadLegends()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.dismiss(animated: false, completion: {self.mainMenuDelegate.clearViewControllers()})
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
        
        for file in files
        {
            print(file.lastPathComponent)
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
    
    @IBAction func newLegendFilePress(_ sender: UIButton) {
        let uniqueString = String(Double(Date.init().timeIntervalSince1970))
        
        do {
            let legendGame = try LegendGame.init(filename: uniqueString)
            
            do {
                try legendGame.saveHeader()
            } catch {
                print("Failed to save header.")
            }
            
        } catch {
            print("Failed to create a legend file of: " + uniqueString)
        }
        
        reloadData()
    }
    
    func populateUI(cell: UICollectionViewCell, index: Int) -> UICollectionViewCell {
        
        (cell as! CollectionButtonViewCell).button!.setTitle(legendGames[index].header.name, for: .normal)
        
        return cell
    }
    
    func getNumberOfItems() -> Int {
        return legendGames.count
    }
    
    func userPressedIndex(index: Int) {
        //self.present(self.storyboard!.instantiateViewController(withIdentifier: "EditorViewController"), animated: false, completion: nil)
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "LegendHeaderEditViewController") as! LegendHeaderEditViewController
        viewController.lmvcDelegate = self
        viewController.legend = legendGames[index]
        viewController.filename = (files[index].absoluteString as NSString).lastPathComponent
        
        self.present(viewController, animated: false, completion: nil)
    }
    
    func reloadData() {
        loadLegends()
    }
}

/*
 //MARK: Archiving Paths
 
 static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
 static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
 */
