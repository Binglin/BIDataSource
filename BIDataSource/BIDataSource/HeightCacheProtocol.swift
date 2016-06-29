//
//  HeightCacheProtocol.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell


public protocol HeightCacheProtocol{
    
}

extension TableViewDelegate where Self: HeightCacheProtocol, Self: IndexPathDataProtocol, Self: CellConfigureProtocol{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return tableView.fd_heightForCellWithIdentifier("cell", configuration: { cell in
            self.configure(cell as! Cell, data: self.dataAt(indexPath))
        })
    }
}

extension TableViewDelegate where Self: HeightCacheProtocol, Self: IndexPathDataProtocol, Self: ListBinderProtocol,
Self.ListBinder : CellBinder, Self.Element == Self.ListBinder.Element{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return tableView.fd_heightForCellWithIdentifier("cell", configuration: { cell in
            ListBinder.bind(cell as! ListBinder.View, withData: self.dataAt(indexPath))
        })
    }
}
