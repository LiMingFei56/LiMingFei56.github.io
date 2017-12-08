---
layout: page
permalink: /ios/guide/basic/tableview
---

Table View

### UITableViewController
UITableView设计来显示一个可滑动的显示多个Item的View。UITableViewController是用来
管理UITableView的，UITableViewController是UIViewController的子类，这是设计用来处理
TableView相关的逻辑。

viewDidLoad 方法中加载数据
numberOfSections 方法配置TableView中有多少sections要显示
tableView int 方法配置一个sections中显示多少行item
tableView UITableViewCell
	dequeueReusableCell 方法根据withIdentifier来识别Cell的复用


### UITableViewCell
TableView中一行Item代表一个UITableViewCell

### Enable a table view controller's editing mode

	navigationItem.leftBarButtonItem = editButtonItem
	
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true
	}

	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
	    if editingStyle == .delete {
	        // Delete the row from the data source
	        meals.remove(at: indexPath.row)
	        tableView.deleteRows(at: [indexPath], with: .fade)
	    } else if editingStyle == .insert {
	        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
	    }
	}

