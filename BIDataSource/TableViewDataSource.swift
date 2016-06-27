//
//  TableViewDataSource.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/15.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


public protocol IBTableController{
    var tableView : UITableView! {get}
}

public protocol CodeTableController{
    var tableView: UITableView { get }
}

public protocol TableViewHeightCacheProtocol{
    
}

// MARK: protocol TableViewDataSource
public protocol TableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func tableView(tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell
    
    func numberOfSections(in TableView: UITableView) -> Int
}


// MARK: extension ListDataProtocol
public extension TableViewDataSource where Self: ListDataProtocol{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
}


// MARK: extension TableViewDataSource cell
public extension TableViewDataSource where Self: IndexPathDataProtocol, Self: ListBinderProtocol,
                                           Self.ListBinder : CellBinder, Self.Element == Self.ListBinder.Element{
    
    func tableView(tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        ListBinder.bind(cell as! ListBinder.View, withData: self.dataAt(indexPath))
        return cell
    }
}


public extension TableViewDataSource where Self: IndexPathDataProtocol, Self: CellConfigureProtocol{
    
    func tableView(tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        self.configure(cell as! Cell, data: self.dataAt(indexPath))
        return cell
    }
}
