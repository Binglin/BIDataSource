//
//  UITableView+queueCell.swift
//  UIlistingDataManager
//
//  Created by 郑林琴 on 16/4/14.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit

// MARK: UITableView extension
extension UITableView{
    
    // MARK: 注册cell方法
    /**
     注册cell identifier为cell类型的字符串
     */
    func queueIn(cell: AnyClass){
        self.queueIn(cell, identifier: String(cell))
    }
    
    /**
     注册cell identifier为cell类型的字符串
     
     - parameter cell:       cell的类型
     - parameter identifier: cell的identifier
     */
    func queueIn(cell: AnyClass, identifier: String){
        let cellString = String(cell)
        
        if let _ = NSBundle.mainBundle().pathForResource(cellString, ofType: "nib") {
            self.registerNib(UINib(nibName: cellString, bundle: nil), forCellReuseIdentifier: identifier)
        }else{
            self.registerClass(cell, forCellReuseIdentifier: identifier)
        }
    }
    
    /**
     获取注册过的cell
     - parameter identifier:
     */
    func queueOutCell<T>(identifier: String) -> T{
        
        return self.dequeueReusableCellWithIdentifier(identifier) as! T
    }
    
    /**
     从队列中获取cell
     identifier为cell类型的字符串
     */
    func queueOutCell<T: UITableViewCell>() -> T{
        return self.dequeueReusableCellWithIdentifier(String(T)) as! T
    }
    
    
    /*
     *
     */
//    func queueIn(cellData: [ReusableViewData]){
//        for item in cellData{
//            self.queueIn(item.reuseViewType, identifier: item.reuseIdentifier)
//        }
//    }
    
//    func queueOut(cellType: ReusableViewData) -> UITableViewCell {
//        
//        let cell = self.dequeueReusableCellWithIdentifier(cellType.identifier)!
//        cellType.bindTo(cell)
//        return cell
//    }
    
}


