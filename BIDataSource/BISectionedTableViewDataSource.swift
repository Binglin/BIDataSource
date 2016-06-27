//
//  BISectionedTableViewDataSource.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/15.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit

// MARK: SectionDataProtocol
public protocol SectionDataProtocol: IndexPathDataProtocol {
    associatedtype Element
    var items : [[Element]] { get set}
    func dataAt(indexPath: NSIndexPath) -> Element
}


public extension SectionDataProtocol{
    func dataAt(indexPath: NSIndexPath) -> Element{
        return self.items[indexPath.section][indexPath.row]
    }
}


public extension TableViewDataSource where Self: SectionDataProtocol{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.items[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.items.count
    }
}


// MARK: SectionADataProtocol
public protocol SectionADataProtocol{
    associatedtype Element
    var items : [Element] { get set }
    func dataAt(indexPath: NSIndexPath) -> Element
}

public extension SectionADataProtocol{
    func dataAt(indexPath: NSIndexPath) -> Element{
        return self.items[indexPath.section]
    }
}

public extension TableViewDataSource where Self: SectionADataProtocol{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.items.count
    }
}



