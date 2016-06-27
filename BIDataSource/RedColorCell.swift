//
//  RedColorCell.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/14.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit

class RedColorCell: UITableViewCell {
    
}

struct ABCCellBinder: CellBinder {
    static func bind(view: RedColorCell, withData d: String) {
        view.textLabel?.text = "CellBinder " + d
    }
}

