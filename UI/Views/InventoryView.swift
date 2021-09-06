//
//  InventoryView.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol InventoryViewDelegate {
    func getInventory() -> ACInventory?
    func activeItemHasChanged(index: Int)
}

class InventoryView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var inventoryDelegate: InventoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 50.0, height: 50.0)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)//UICollectionView.init(frame: frame)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let classCell = (InventoryViewCell.self)
        
        collectionView.register(classCell, forCellWithReuseIdentifier: "InventoryCell")
        collectionView.backgroundColor = UIColor.init(red: CGFloat(0), green: CGFloat(0.8), blue: CGFloat(1.0), alpha: CGFloat(0.3))
        
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let inventory = inventoryDelegate?.getInventory()
        if inventory != nil
        {
            return (inventory?.contents.count)!
        }
        else
        {
            return 0
        }
    }
    
    @objc func setActiveIndex(sender: UICollectionViewCell)
    {
        self.inventoryDelegate?.activeItemHasChanged(index: sender.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InventoryCell", for: indexPath)
        
        let inventory = inventoryDelegate?.getInventory()
        
        if (inventory?.contents[indexPath.row] != nil)
        {
            if (inventory?.contents[indexPath.row].typeInv.image != nil)
            {
                let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(0.0), y: CGFloat(0.0), width: cell.bounds.width, height: cell.bounds.height))
                imageView.image = inventory?.contents[indexPath.row].typeInv.image
                
                cell.addSubview(imageView)
            }
            else
            {
                cell.backgroundColor = Constants.ActiveUIColor
            }
        }
        else
        {
            cell.backgroundColor = Constants.NormalUIColor
        }
        
        let button = UIButton.init(frame: cell.bounds)
        button.addTarget(self, action: #selector(setActiveIndex(sender:)), for: UIControlEvents.touchUpInside)
        button.tag = indexPath.row
        cell.addSubview(button)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 50.0, height: 50.0)
    }
}
