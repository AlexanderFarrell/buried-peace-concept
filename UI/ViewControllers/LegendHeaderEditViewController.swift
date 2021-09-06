//
//  LegendHeaderEditViewController.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/24/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class LegendHeaderEditViewController: UIViewController {
    var legend: LegendGame!
    var filename: String!
    
    //@IBOutlet var LegendNameOutlet: UILabel!
    @IBOutlet var LegendNameTextFieldOutlet: UITextField!
    @IBOutlet var LegendDescriptionOutlet: UITextView!
    @IBOutlet var LegendImageViewOutlet: UIImageView!
    
    var originalHeight: CGFloat = CGFloat(0.0)
    var lmvcDelegate: LMVCDelegate!
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try legend.loadHeader()
        } catch {
            print("Legend failed to load header.")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        LegendNameTextFieldOutlet.text = legend.header.name
        LegendDescriptionOutlet.text = legend.header.descriptionLegend
        
        LegendNameTextFieldOutlet.keyboardAppearance = UIKeyboardAppearance.dark
        LegendDescriptionOutlet.keyboardAppearance = UIKeyboardAppearance.dark
        
        originalHeight = self.view.bounds.height

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        legend.header.descriptionLegend = LegendDescriptionOutlet.text
        legend.header.name = LegendNameTextFieldOutlet.text!
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        do {
            try legend.saveHeader()
        } catch {
            print("Legend did not save the header when exiting the header view controller. All data inputted is lost.")
        }
        
        lmvcDelegate.reloadData()
    }
    
    @objc func keyboardWillShow(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            self.view.frame.size.height = originalHeight - keyboardSize.height
            
            
            /*if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }*/
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification)
    {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            //self.view.bounds.size.height = originalHeight
            self.view.frame.size.height = originalHeight
            
            /*if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.width
            }*/
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func chapterListButtonPress(_ sender: Any) {
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
