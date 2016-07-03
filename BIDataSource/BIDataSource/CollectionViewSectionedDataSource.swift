//
//  CollectionViewSectionedDataSource.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


public extension CollectionViewDataSource where Self: SectionDataProtocol{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.items[section].count
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return self.items.count
    }

}



public extension CollectionViewDataSource where Self: SectionADataProtocol{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.items.count
    }
}



extension CollectionViewDataSource where Self: SectionDataProtocol, Self.Element == ReusableViewData{
    func tableView(tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell{
        let item = self.dataAt(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(item.identifier)!
        item.build(cell, AtIndexPath: indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let item = self.dataAt(indexPath)
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(item.identifier, forIndexPath: indexPath)
        item.build(cell, AtIndexPath: indexPath)
        return cell
    }
}