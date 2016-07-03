//
//  RowItem.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/30.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


public protocol ReusableView{
    static var identifier: String {get}
}

extension ReusableView where Self: UIView{
    public static var identifier: String{
        get{
            return String(self)
        }
    }
}


extension UITableViewCell: ReusableView{}

extension UITableViewHeaderFooterView: ReusableView{}

extension UICollectionReusableView: ReusableView{}


public protocol ReusableViewData{
    var identifier: String {get}
    func build(cell:ReusableView, AtIndexPath indexPath: NSIndexPath)
}


public struct RowItem<T: CellBinder where T.View:ReusableView>: ReusableViewData{
    
    let data: T.Element
    public let identifier: String
    
    let factory: ((view: T.View, indexPath: NSIndexPath, data: T.Element) -> Void)?
    
    init(identifier: String?,
         data: T.Element,
         viewFactory: ((view: T.View, indexPath: NSIndexPath, data: T.Element) -> Void)?) {
        self.data = data
        self.identifier = identifier ?? T.View.identifier
        self.factory = viewFactory
    }
    
    public func build(cell: ReusableView, AtIndexPath indexPath: NSIndexPath) {
        T.bind(cell as! T.View, withData: self.data)
        self.factory?(view: cell as! T.View, indexPath: indexPath, data: self.data)
    }
}
