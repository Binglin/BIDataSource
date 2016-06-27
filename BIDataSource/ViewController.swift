//
//  ViewController.swift
//  BIDataSource
//
//  Created by ET|冰琳 on 16/6/14.
//  Copyright © 2016年 Ice Butterfly. All rights reserved.
//

import UIKit


// MARK: ----
class ViewController: UIViewController , TableViewDataSource, ListDataProtocol, ListBinderProtocol, UITableViewDelegate{
    
    var items: [String] = []
    
    typealias ListBinder = ABCCellBinder

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.items.appendContentsOf(["cell use only once", "cell user multiple times"])
        self.tableView.setDataSource(self)
        self.tableView.delegate = self
        
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
        
        self.tableView.queueIn(RedColorCell.classForCoder(), identifier: "cell")
        self.items.append("first cell")
        self.items.append("second cell")
        self.tableView.setDataSource(self)
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
    typealias ListBinder = ABCCellBinder

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.queueIn(RedColorCell.self, identifier: "cell")
        self.items.appendContentsOf(["row1", "row2"])
        self.tableView.setDataSource(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
}


