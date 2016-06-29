//
//  CollectionViewDataSource.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit

public protocol CollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
}

public extension CollectionViewDataSource where Self: ListDataProtocol{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.items.count
    }
}

// MARK: extension CollectionViewDataSource cell
public extension CollectionViewDataSource where Self: IndexPathDataProtocol, Self: ListBinderProtocol,
Self.ListBinder : CellBinder, Self.Element == Self.ListBinder.Element{
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        ListBinder.bind(cell as! ListBinder.View, withData: self.dataAt(indexPath))
        return cell
    }
}


public extension CollectionViewDataSource where Self: IndexPathDataProtocol, Self: CellConfigureProtocol{
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        self.configure(cell as! Cell, data: self.dataAt(indexPath))
        return cell
    }
}


// MARK: _BICollectionViewDataSource
class _BICollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var dataSource: CollectionViewDataSource
    
    init(dataSource: CollectionViewDataSource) {
        self.dataSource = dataSource
        super.init()
    }
    
    /* 保持ower一致的生命周期 省略本类实例作为属性*/
    @IBOutlet var ower: AnyObject!{
        didSet{
            objc_setAssociatedObject(ower, "BICollectionViewDataSourceOwner", self, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        return self.dataSource.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return self.dataSource.numberOfSectionsInCollectionView(collectionView)
    }

}
