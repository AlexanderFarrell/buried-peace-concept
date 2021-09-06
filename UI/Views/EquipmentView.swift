//
//  EquipmentView.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 11/11/17.
//  Copyright © 2017 MorphSight. All rights reserved.
//

import UIKit

protocol EquipmentViewDelegate {
    func getEquipmentList() -> [InventoryItem]
    func activeItemHasChanged(index: Int)
}

class EquipmentView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var equipmentDelegate: EquipmentViewDelegate?
    
    var weapons: [Weapon]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: 50.0, height: 50.0)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)//UICollectionView.init(frame: frame)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let classCell = (EquipmentViewCell.self)
        
        collectionView.register(classCell, forCellWithReuseIdentifier: "EquipmentCell")
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
        return equipmentDelegate!.getEquipmentList().count
    }
    
    @objc func setActiveIndex(sender: UICollectionViewCell)
    {
        self.equipmentDelegate?.activeItemHasChanged(index: sender.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EquipmentCell", for: indexPath)
        
        let equipmentList = equipmentDelegate!.getEquipmentList()
        
        if (equipmentList[indexPath.row].typeInv.image != nil)
        {
            let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(0.0), y: CGFloat(0.0), width: cell.bounds.width, height: cell.bounds.height))
            imageView.image = equipmentList[indexPath.row].typeInv.image
            
            cell.addSubview(imageView)
        }
        else
        {
            cell.backgroundColor = Constants.ActiveUIColor
        }
        
        /*if (equipmentList[indexPath.row] != nil)
        {
            if (equipmentList[indexPath.row].typeInv.image != nil)
            {
                let imageView = UIImageView.init(frame: CGRect.init(x: CGFloat(0.0), y: CGFloat(0.0), width: cell.bounds.width, height: cell.bounds.height))
                imageView.image = equipmentList[indexPath.row].typeInv.image
                
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
        }*/
        
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
