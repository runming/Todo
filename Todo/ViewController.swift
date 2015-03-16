//
//  ViewController.swift
//  Todo
//
//  Created by 华润明 on 15/3/16.
//  Copyright (c) 2015年 华润明. All rights reserved.
//

import UIKit

var todos:[ToDoModel] = []
var filteredTodos:[ToDoModel] = []

func dateFromString(dateStr: String) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-mm-dd"
    let date = dateFormatter.dateFromString(dateStr)
    return date
}


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todos = [ToDoModel(id: "1", image: "selected-socia", title: "社交", date: dateFromString("2015-03-16")!),ToDoModel(id: "2", image: "selected-food", title: "美食", date: dateFromString("2015-03-15")!),ToDoModel(id: "3", image: "selected-read", title: "阅读", date: dateFromString("2015-03-14")!),ToDoModel(id: "4", image: "selected-game", title: "游戏", date: dateFromString("2015-03-13")!)]
        navigationItem.leftBarButtonItem = editButtonItem()
        
        var contentoffset = tableView.contentOffset
        contentoffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentoffset

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == searchDisplayController?.searchResultsTableView{
            return filteredTodos.count
        }
        else {return todos.count}
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as UITableViewCell
        var todo : ToDoModel
        if tableView == searchDisplayController?.searchResultsTableView{
            todo = filteredTodos[indexPath.row] as ToDoModel
        }
        else {
            todo = todos[indexPath.row] as ToDoModel
        }
        var image = cell.viewWithTag(1) as UIImageView
        var title = cell.viewWithTag(2) as UILabel
        var date = cell.viewWithTag(3) as UILabel
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date.text = dateFormatter.stringFromDate(todo.date)
        return cell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            todos.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return editing
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool{
        filteredTodos = todos.filter(){$0.title.rangeOfString(searchString) != nil}
        return true
    }
    
    @IBAction func close(segue: UIStoryboardSegue){
        print("closed")
        tableView.resignFirstResponder()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EditTodo" {
            var vc = segue.destinationViewController as DetailViewController
            var indexPath = tableView.indexPathForSelectedRow()
            if let index = indexPath {
                vc.todo = todos[index.row]
            }
        }
    }
}

