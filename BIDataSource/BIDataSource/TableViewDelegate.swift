//
//  TableViewDelegate.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


public protocol TableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
}


extension TableViewDelegate{
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return tableView.rowHeight;
    }
}


class _BITableViewDelegate: NSObject, UITableViewDelegate{
    
    var delegate: TableViewDelegate
    
    init(delegate: TableViewDelegate) {
        self.delegate = delegate
        super.init()
    }
    
    @IBOutlet var ower: AnyObject!{
        didSet{
            objc_setAssociatedObject(ower, "BITableViewDelegateOwner", self, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.delegate.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
}

