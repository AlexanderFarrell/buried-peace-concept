//
//  LoadLegendViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/17/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class LoadLegendViewController: UIViewController, LegendSaveDataSource {
    
    @IBOutlet var FileButtonOutlet: UIButton!
    @IBOutlet var selectorView: CollectionSelectorView!
    var mainMenuDelegate: MainMenuDelegate!
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    FileButtonOutlet.setImage(FileButtonOutlet.image(for: .normal)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState.normal)
        
        FileButtonOutlet.imageView!.tintColor = UIColor.init(red: CGFloat(0.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0))
        
        selectorView.legendSaveDataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.dismiss(animated: false, completion: {self.mainMenuDelegate.clearViewControllers()})
    }
    
    func populateUI(cell: UICollectionViewCell, index: Int) -> UICollectionViewCell {
        //Add code
        
        return cell
    }
    
    func getNumberOfItems() -> Int {
        return 28
    }
    
    func userPressedIndex(index: Int) {
        self.present(self.storyboard!.instantiateViewController(withIdentifier: "LoadingViewConroller"), animated: false, completion: nil)
    }

}
