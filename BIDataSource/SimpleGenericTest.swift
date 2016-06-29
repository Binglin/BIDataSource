//
//  SimpleGenericTest.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import Foundation


protocol RowItemType {
    associatedtype ViewData
    associatedtype ViewType
    var data: ViewData {get}
    func build(cell: ViewType, AtIndexPath indexPath: NSIndexPath)
    
}

struct RowDataItem<View, Data> : ReusableViewDataType {
    
    let data: Data
    
    var identifier = String(View)
    func build(cell: ReusableViewType, AtIndexPath indexPath: NSIndexPath) {
        if let c = cell as? GenericBinder{
            c.bindWith(self.data)
        }
    }
}

