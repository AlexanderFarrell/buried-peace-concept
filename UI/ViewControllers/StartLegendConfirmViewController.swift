//
//  StartLegendConfirmViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/18/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class StartLegendConfirmViewController: UIViewController {
    var legend: LegendGame!
    @IBOutlet var legendNameDisplay: UILabel!
    @IBOutlet var legendDescriptionDisplay: UITextView!
    @IBOutlet var legendIconDisplay: UIImageView!
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try legend.loadHeader()
            legendNameDisplay.text = legend.header.name
            legendDescriptionDisplay.text = legend.header.descriptionLegend
            
        } catch {
            let alert = UIAlertController.init(title: "Error", message: "Failed to load legend.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playLegendButtonPress(_ sender: UIButton) {
        let loadingViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
        loadingViewController.legend = legend
        self.present(loadingViewController, animated: false, completion: nil)
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
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
