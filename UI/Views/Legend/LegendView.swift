//
//  LegendView.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/24/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

class LegendView: UIView, UIScrollViewDelegate {
    var legend: LegendGame!
    var isEditable: Bool = false
    
    private var heightOfScrollView = 0.0
    let descriptionWeightWidth = 0.67
    
    override func awakeFromNib() {
        setupView()
        
        super.awakeFromNib()
    }
    
    func setupView()
    {
        setupTitle()
        setupImage()
        setupDescription()
        
    }
    
    func setupTitle()
    {
        
    }
    
    func setupImage()
    {
        
    }
    
    func setupDescription()
    {
        
    }
    
    func setupPlayLegendButton()
    {
        
    }
    
    
}
