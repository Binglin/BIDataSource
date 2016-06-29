//
//  ListBinders.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


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

/** setting cell
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



