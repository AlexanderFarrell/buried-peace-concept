//
//  OptionsViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/17/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    var mainMenuDelegate: MainMenuDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.dismiss(animated: false, completion: {self.mainMenuDelegate.clearViewControllers()})
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
