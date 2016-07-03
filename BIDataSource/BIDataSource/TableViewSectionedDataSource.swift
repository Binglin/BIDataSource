//
//  TableViewSectionedDataSource.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/15.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit



public extension TableViewDataSource where Self: SectionDataProtocol{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.items[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return self.items.count
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



extension TableViewDataSource where Self: SectionDataProtocol, Self.Element == ReusableViewData{
    func tableView(tableView: UITableView, cellForRowAt indexPath: NSIndexPath) -> UITableViewCell{
        let item = self.dataAt(indexPath)
        let cell = tableView.dequeueReusableCellWithIdentifier(item.identifier)!
        item.build(cell, AtIndexPath: indexPath)
        return cell
    }
}



