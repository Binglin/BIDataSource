//
//  DynamicViewData.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


public protocol ReusableViewType{
    static var identifier: String {get}
}

extension ReusableViewType where Self: UIView{
    public static var identifier: String{
        get{
            return String(self)
        }
    }
}


extension UITableViewCell: ReusableViewType{}

extension UITableViewHeaderFooterView: ReusableViewType{}

extension UICollectionReusableView: ReusableViewType{}


public protocol ReusableViewDataType{
    var identifier: String {get}
    func build(cell:ReusableViewType, AtIndexPath indexPath: NSIndexPath)
}


public struct RowItem<T: CellBinder where T.View:ReusableViewType>: ReusableViewDataType{
    
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
    
    public func build(cell: ReusableViewType, AtIndexPath indexPath: NSIndexPath) {
        T.bind(cell as! T.View, withData: self.data)
        self.factory?(view: cell as! T.View, indexPath: indexPath, data: self.data)
    }
}




public protocol GenericBinder{
    func bindWith<T>( data: T)
}

extension UITableViewCell: GenericBinder{
    public func bindWith<T>( data: T) {
        print("tableviewcell extension")
    }
}

extension RedColorCell{
    func bindWith(data: String) {
        
    }
}



struct aaa {
    func aaa(){
        let a = RowItem<RedColorCellBinder>(identifier: "string", data: "", viewFactory: nil)
        let b = RowItem<BlueColorCellBinder>(identifier: "blue", data: 123, viewFactory: nil)
        let aaa : [ReusableViewDataType] = [a,b]
    }
}



