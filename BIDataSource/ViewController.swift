//
//  ViewController.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/14.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


// MARK: ----
class ViewController: UIViewController , TableViewDataSource, ListDataProtocol, ListBinderProtocol, TableViewDelegate{
    
    var items: [String] = []
    
    typealias ListBinder = RedColorCellBinder

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.items.appendContentsOf([
            "CellConfigureProtocol:cell use only once",
            "ListBinderProtocol user multiple times",
            "dynamic cells: ReusableViewDataTypeController",
            "GenericDataTableViewController"
        ])
        self.tableView.setBIDataSource(self)
        self.tableView.setBIDelegate(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(CellConfigureProtocolViewController(), animated: true)
            break
        case 1:
            self.navigationController?.pushViewController(ListBinderProtocolViewController(), animated: true)
            break
        case 2:
            self.navigationController?.pushViewController(ReusableViewDataTypeController(), animated: true)
            break
        case 3:
            self.navigationController?.pushViewController(GenericDataTableViewController(), animated: true)
            break
        default:
            break
        }
    }
}

// MARK: CellConfigureProtocolViewController
class CellConfigureProtocolViewController: UIViewController, ListDataProtocol, TableViewDataSource,
CellConfigureProtocol{
    
    var items: [String] = []
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        
        self.tableView.queueIn(RedColorCell.self, identifier: "cell")
        self.items.append("first cell")
        self.items.append("second cell")
        self.tableView.setBIDataSource(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
    
    /*一个cell 仅单次使用使用*/
    func configure(cell: RedColorCell , data: String) {
        cell.textLabel?.text = "once cell , cell configure protocol \(data)"
    }
}

// MARK: ListBinderProtocolViewController
class ListBinderProtocolViewController: UIViewController , ListDataProtocol, ListBinderProtocol, TableViewDataSource{
    
    var items: [String] = []
    
    /*一个cell 多处使用适用*/
    typealias ListBinder = RedColorCellBinder

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.queueIn(RedColorCell.self, identifier: "cell")
        self.items.appendContentsOf(["row1", "row2"])
        self.tableView.setBIDataSource(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
}


class ReusableViewDataTypeController: UIViewController, SectionDataProtocol, TableViewDataSource , UITableViewDelegate{
    
    var items: [[ReusableViewDataType]] = []
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.queueIn(RedColorCell)
        self.tableView.queueIn(BlueColorCell)
        
        
        self.items.append([
            RowItem<RedColorCellBinder>(identifier: nil, data: "", viewFactory: nil),
            RowItem<BlueColorCellBinder>(identifier: nil, data: 123, viewFactory: { (view, indexPath, data) in
                view.backgroundColor = UIColor.orangeColor()
            })
        ])
    
        
        self.tableView.setBIDataSource(self)
        self.tableView.delegate   = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        }
        return 100
    }
}


class GenericDataTableViewController: UIViewController , SectionDataProtocol, TableViewDataSource{
    
    var tableView = UITableView()
    
    var items: [[ReusableViewDataType]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.queueIn(RedColorCell)
        self.tableView.queueIn(BlueColorCell)
        
        
        self.items.append([
            RowDataItem<RedColorCell, String>(data: "abc", identifier: String(RedColorCell)),
            RowDataItem<BlueColorCell, Int>(data: 123, identifier: String(BlueColorCell))
            ])
        self.tableView.setBIDataSource(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 60
        }
        return 100
    }

}


