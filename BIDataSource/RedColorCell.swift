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

struct RedColorCellBinder: CellBinder {
    static func bind(view: RedColorCell, withData d: String) {
        view.textLabel?.text = "RedColorCell " + d
        view.backgroundColor = UIColor.redColor();
    }
}


class BlueColorCell: UITableViewCell {
    
}

struct BlueColorCellBinder: CellBinder {
    static func bind(view: BlueColorCell, withData d: Int) {
        view.textLabel?.text = "BlueColorCell \(d)"
        view.backgroundColor = UIColor.blueColor()
    }
}

