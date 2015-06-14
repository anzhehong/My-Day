//
//  TodoUIViewController.swift
//  My Day
//
//  Created by MarK on 5/31/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class TodoUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,TableViewCellDelegate {
    
    var todoList = [NSData]()
//    var todoList = [TodoModel]()
    var tempArray = [TodoModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

//        todoList.append(TodoModel())
//                todoList.append(TodoModel())
//                todoList.append(TodoModel())
//                todoList.append(TodoModel())
//                todoList.append(TodoModel())
//                todoList.append(TodoModel())
        
//        ////
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
//        var toDoCell = storyboard?.instantiateViewControllerWithIdentifier("todoCell") as TableViewCell
        tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "todoCell")
        tableView.separatorStyle = .None
        
        tableView.backgroundColor = UIColor.blackColor()
//        tableView.rowHeight = 50.0
        
        
        self.userDefaultConfig()
        
        
        //add navigation item
//        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    
    //MARK - ViewControllerLife
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Default
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.brownColor()]
//        nav?.setBackgroundImage(UIImage(named: "courseBackground"), forBarMetrics: UIBarMetrics.Default)
        nav?.hidden = false
    }

    func userDefaultConfig() {
        //load userDefault
        var customerDefault = NSUserDefaults.standardUserDefaults()
//        customerDefault.removeObjectForKey("Todo")
        
        //weather first time create todo list  判断第一次启动
        if let list = customerDefault.objectForKey("Todo") as? [NSData]{
            //already have a todo list in user default, get the todoList
            todoList = list
            
            tempArray = [TodoModel]()
            for (var i = 0; i < list.count; i++){
                tempArray.append(TodoModel.NSDataToTodo(list[i]))
            }

            
        }else{
            //don't have a todo list in user default, create an empty list in userDefault
            customerDefault.setObject([NSData](), forKey: "Todo")
        }

    }
    
    
    //MARK - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell") as UITableViewCell
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell") as TableViewCell
        cell.selectionStyle = .None
        
        let item = TodoModel.NSDataToTodo(todoList[indexPath.row])
//        let item = todoList[indexPath.row]
        
//        cell.textLabel?.backgroundColor = UIColor.clearColor()
        
        //set background color
        //RGB:255 69 0
//        let currentIndex = indexPath.row as Int
//        let currentBlue = CGFloat(currentIndex * 6)
//        let currentGreen = CGFloat(69 + currentIndex*12)
//        let currentColor = UIColor(red: 255/255, green: currentGreen/255, blue: currentBlue/255, alpha: 1)
//        
//        cell.backgroundColor = currentColor
        
        
        //get labels in the cell
//        let todoTitle = cell.viewWithTag(101) as UILabel
//        let todoType = cell.viewWithTag(102) as UILabel
//        let todoDate = cell.viewWithTag(103) as UILabel
        let todoTitle = cell.lll1 as UILabel
        let todoType = cell.lll2 as UILabel
        let todoDate = cell.lll3 as UILabel
        
        //set the text of the label
        var todoItem = TodoModel.NSDataToTodo(todoList[indexPath.row])
        todoTitle.text = todoItem.title
        todoType.text = todoItem.type
        todoDate.text = todoItem.date
        
        cell.delegate = self
        cell.toDoItem = item
        return cell
    }
    
    func toDoItemDeleted(toDoItem: TodoModel) {
//        let tempList = TodoModel.NSDataToTodo(todoList)
//        println(tempArray)
//        println(toDoItem)
//        println(tempArray)

        self.userDefaultConfig()
        
        var index = 0
        for(var i = tempArray.count-1 ; i >= 0; i--) {
            println("toDoItem.id = \(toDoItem.id)   tempArray.id  \(tempArray[i].id)")
            if toDoItem.id == tempArray[i].id {
                index = i
                println("index ::::: \(index)")
                break
            }
        }
        
//        let index = (tempArray as NSArray).indexOfObject(toDoItem)
        println(index)
        if index == NSNotFound { return }
        
        // could removeAtIndex in the loop but keep it here for when indexOfObject works
        todoList.removeAtIndex(index)
        
        // use the UITableView to animate the removal of this row
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        
        
        //update list in user default
        var customerDefault = NSUserDefaults.standardUserDefaults()
        customerDefault.setObject(todoList, forKey: "Todo")
        tableView.reloadData()
        tableView.endUpdates()
    }
    
    func toDoItemCompleted(todoItem: TodoModel) {
        self.userDefaultConfig()
        var index = 0
        for(var i = tempArray.count-1 ; i >= 0; i--) {
            println("todoItem = \(todoItem.id)   tempArray.id  \(tempArray[i].id)")
            if todoItem.id == tempArray[i].id {
                index = i
                println("index ::::: \(index)")
                break
            }
        }
        println(index)
        if index == NSNotFound { return }

        
        // use the UITableView to animate the removal of this row
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(forRow: index, inSection: 0)
//        tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
        var tempTodoItem = TodoModel.NSDataToTodo(todoList[index])
        tempTodoItem.completed = true
        todoList[index] = tempTodoItem.todoToNSData()!
        
        
        //update list in user default
        var customerDefault = NSUserDefaults.standardUserDefaults()
        customerDefault.setObject(todoList, forKey: "Todo")
//        tableView.reloadData()
        tableView.endUpdates()
    }
    
    //MARK - UITableViewDelegate
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = todoList.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
            cell.backgroundColor = colorForIndex(indexPath.row)
    }
    
    //    左滑动删除
    //MARK - UITableViewDelegate
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            
//            //delete current todo item
//            todoList.removeAtIndex(indexPath.row)
//            
//            //update list in user default
//            var customerDefault = NSUserDefaults.standardUserDefaults()
//            customerDefault.setObject(todoList, forKey: "Todo")
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//            self.tableView.reloadData()
//        }
//    }
    
    //move items
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    
//    上下调整
//    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        let currentDefault = NSUserDefaults.standardUserDefaults()
//        if let list = currentDefault.objectForKey("Todo") as? [NSData]{
//            var todoList = list
//            let todo = todoList.removeAtIndex(sourceIndexPath.row)
//            todoList.insert(todo, atIndex: destinationIndexPath.row)
//            currentDefault.setObject(todoList, forKey: "Todo")
//        }
//        self.tableView.reloadData()
//        viewDidLoad()
//    }
    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
    
    

    
    //Editing mdoel
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
//    确定返回
    //unwind
    @IBAction func close(segue: UIStoryboardSegue){
        self.tableView.reloadData()
        viewDidLoad()
    }
    
//    每一项点击之后可编辑
    //editSegue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editTodo"{
            var vc = segue.destinationViewController as AddTodoItemUIViewController
            var indexPath = tableView.indexPathForSelectedRow()
            
            if let index = indexPath{
//                vc.currentTodoItem = TodoModel.NSDataToTodo(todoList[index.row])
                vc.currentIndex = index.row
            }
        }
    }
}
