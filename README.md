# BIDataSource
a wrapper of UITableViewDataSource and UITableViewDelegate of UITableView


``` objective-cØ
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
```


``` objective-c
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


```