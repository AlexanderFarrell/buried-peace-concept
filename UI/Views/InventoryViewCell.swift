//
//  InventoryViewCell.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

class InventoryViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.red
        imageView = UIImageView.init(frame: self.frame)
        self.addSubview(imageView)
    }
}
