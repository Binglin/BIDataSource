//
//  BITableViewDataSource.swift
//  UIlistingDataManager
//
//  Created by 郑林琴 on 16/6/10.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit
//import UITableView_FDTemplateLayoutCell


/*
 * cell的界面显示类
 * 一个cell多处使用的复用 单独创建一个Binder类or struct
 * write once user everywhere
 */

public protocol CellBinder{
    associatedtype Element
    associatedtype View
    
    static func bind(view: View, withData: Element)
}

/**
 *  列表cell多处使用时 使用本协议 
 */
public protocol ListBinderProtocol{
    associatedtype ListBinder
}

/* 
 * 一个cell无需复用的情况 通常使用UIViewController实现本协议，cell的界面设置在controller中进行
 */
public protocol CellConfigureProtocol{
    associatedtype Element
    associatedtype Cell
    func configure(cell: Cell, data: Element)
}



public protocol ListInteractionProtocol{
    associatedtype ListBinder
}

// MARK:
public protocol IndexPathDataProtocol{
    associatedtype Element
    func dataAt(indexPath: NSIndexPath) -> Element
}

// MARK: ListDataProtocol
public protocol ListDataProtocol:IndexPathDataProtocol {
    associatedtype Element
    var items :  [Element] { get set}
}

public extension ListDataProtocol{
    func dataAt(indexPath: NSIndexPath) -> Element{
        return self.items[indexPath.row]
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


public protocol HeightCacheProtocol{
    
}

public protocol TableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
}

extension TableViewDelegate{
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
    }
}

/*
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
*/



// MARK: -
extension UITableView{

    func setDataSource(dataSource: TableViewDataSource){
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

