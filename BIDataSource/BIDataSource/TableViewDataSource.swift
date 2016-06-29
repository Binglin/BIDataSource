//
//  TableViewDataSource.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/10.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


public protocol IBTableController{
    var tableView : UITableView! {get}
}

public protocol CodeTableController{
    var tableView: UITableView { get }
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



// MARK: _BITableViewDataSource
class _BITableViewDataSource: NSObject, UITableViewDataSource {
    
    var dataSource: TableViewDataSource
    
    init(dataSource: TableViewDataSource) {
        self.dataSource = dataSource
        super.init()
    }
    
    /* 保持ower一致的生命周期 省略本类实例作为属性*/
    @IBOutlet var ower: AnyObject!{
        didSet{
            objc_setAssociatedObject(ower, "BITableViewDataSourceOwner", self, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.dataSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return self.dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return self.dataSource.numberOfSections(in: tableView)
    }
}
