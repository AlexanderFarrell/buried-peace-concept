//
//  DamageLabelView.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 12/6/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class DamageLabelView: UIView {
    var labelView: UILabel!
    var imageView: UIImageView!
    var delegate: DamageUISetDelegate
    
    init(frame: CGRect, image: UIImage, attributedText: NSAttributedString, delegateIn: DamageUISetDelegate) {
        assert(frame.width > frame.height, "DamageLabel has to have a larger width than the height.")
        
        delegate = delegateIn
        
        super.init(frame: frame)
        
        imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(frame.width - frame.height), y: CGFloat(0.0), width: frame.height, height: frame.height))
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        
        labelView = UILabel.init(frame: CGRect.init(x: CGFloat(0.0), y: CGFloat(0.0), width: frame.width - frame.height, height: frame.height))
        labelView.attributedText = attributedText
        
        self.addSubview(imageView)
        self.addSubview(labelView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func breakdown()
    {
        labelView.removeFromSuperview()
        imageView.removeFromSuperview()
        
        labelView = nil
        imageView = nil
    }
}
