//
//  UITableVIew+BIDataSource.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


// MARK: -
extension UITableView{
    
    func setBIDataSource(dataSource: TableViewDataSource){
        let d = _BITableViewDataSource(dataSource: dataSource)
        d.ower = self
        self.dataSource = d
    }
    
    func setBIDelegate(delegate: TableViewDelegate){
        let d = _BITableViewDelegate(delegate: delegate)
        d.ower = self
        self.delegate = d
    }
}
