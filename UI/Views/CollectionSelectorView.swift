//
//  CollectionSelectorView.swift
//  BuriedPeace
//
//  Created by Alexander Farrell on 1/18/18.
//  Copyright © 2018 MorphSight. All rights reserved.
//

import UIKit

protocol LegendSaveDataSource {
    func populateUI(cell: UICollectionViewCell, index: Int) -> UICollectionViewCell
    func getNumberOfItems() -> Int
    func userPressedIndex(index: Int)
}

class CollectionSelectorView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var legendSaveDataSource: LegendSaveDataSource!
    
    var savedGamesData = [SavedGame]()
    var legendFilesData = [LegendGame]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: self.bounds.width, height: 65.0)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let classCell = (CollectionButtonViewCell.superclass())
        
        collectionView.register(classCell, forCellWithReuseIdentifier: "ColButtonVC")
        collectionView.backgroundColor = UIColor.init(red: CGFloat(0), green: CGFloat(0.0), blue: CGFloat(0.0), alpha: CGFloat(0.0))
        
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: floor(Double(self.bounds.width) * 0.44), height: 65.0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 7.0
        layout.sectionInset = UIEdgeInsets.init(top: CGFloat(12.0), left: CGFloat(12.0), bottom: CGFloat(12.0), right: CGFloat(12.0))
        print(self.bounds.width)
        
        
        collectionView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //let classCell = (CollectionButtonViewCell.layerClass)
        
        collectionView.register(CollectionButtonViewCell.self, forCellWithReuseIdentifier: "ColButtonVC")
        collectionView.backgroundColor = UIColor.init(red: CGFloat(0), green: CGFloat(0.0), blue: CGFloat(0.0), alpha: CGFloat(0.0))
        
        self.addSubview(collectionView)
    }
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        
        self.collectionView.autoresizingMask.insert(.flexibleWidth)
        self.collectionView.autoresizingMask.insert(.flexibleHeight)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = true
        
        
        //self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //self.contentView.translatesAutoresizingMaskIntoConstraints = YES;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return legendSaveDataSource.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: CollectionButtonViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColButtonVC", for: indexPath) as! CollectionButtonViewCell
        
        cell.backgroundColor = UIColor.init(red: CGFloat(0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(0.25))
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 10.0
        
        print(self.bounds.width)
        
        if cell.button != nil
        {
            cell.button!.removeFromSuperview()
            cell.button = nil
        }
        
        let button = UIButton.init(frame: cell.bounds)
        button.addTarget(self, action: #selector(pressIndex(sender:)), for: UIControlEvents.touchUpInside)
        button.tag = indexPath.row
        button.setTitleColor(UIColor.init(red: CGFloat(0.0), green: CGFloat(1.0), blue: CGFloat(1.0), alpha: CGFloat(1.0)), for: UIControlState.normal)
        button.setTitle("Legend", for: UIControlState.normal)
        cell.addSubview(button)
        cell.button = button
        
        cell = self.legendSaveDataSource.populateUI(cell: cell, index: indexPath.row) as! CollectionButtonViewCell
        
        return cell
    }
    
    @objc func pressIndex(sender: UICollectionViewCell)
    {
        self.legendSaveDataSource.userPressedIndex(index: sender.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: floor(Double(self.bounds.width) * 0.47), height: 65.0)
    }
}


















