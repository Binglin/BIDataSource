//
//  SectionDataProtocols.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/28.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit

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


// MARK: SectionDataProtocol
public protocol SectionDataProtocol: IndexPathDataProtocol {
    associatedtype Element
    var items : [[Element]] { get set}
    func dataAt(indexPath: NSIndexPath) -> Element
}


public extension SectionDataProtocol{
    func dataAt(indexPath: NSIndexPath) -> Element{
        return self.items[indexPath.section][indexPath.row]
    }
}


// MARK: SectionADataProtocol
public protocol SectionADataProtocol{
    associatedtype Element
    var items : [Element] { get set }
    func dataAt(indexPath: NSIndexPath) -> Element
}

public extension SectionADataProtocol{
    func dataAt(indexPath: NSIndexPath) -> Element{
        return self.items[indexPath.section]
    }
}
