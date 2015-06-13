//
//  TodoUIViewController.swift
//  My Day
//
//  Created by MarK on 5/31/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class TodoUIViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todoList = [NSData]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //load userDefault
        var customerDefault = NSUserDefaults.standardUserDefaults()
        
        //weather first time create todo list  判断第一次启动
        if let list = customerDefault.objectForKey("Todo") as? [NSData]{
            //already have a todo list in user default, get the todoList
            todoList = list
            
        }else{
            //don't have a todo list in user default, create an empty list in userDefault
            customerDefault.setObject([NSData](), forKey: "Todo")
        }
        
        //add navigation item
        
//        navigationItem.leftBarButtonItem = editButtonItem()


    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Default
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.brownColor()]
//        nav?.setBackgroundImage(UIImage(named: "courseBackground"), forBarMetrics: UIBarMetrics.Default)
        nav?.hidden = false
        

        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    //MARK - UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell") as UITableViewCell
        
        //set background color
        
        //RGB:255 69 0
        let currentIndex = indexPath.row as Int
        let currentBlue = CGFloat(currentIndex * 6)
        let currentGreen = CGFloat(69 + currentIndex*12)
        
        let currentColor = UIColor(red: 255/255, green: currentGreen/255, blue: currentBlue/255, alpha: 1)
        
        cell.backgroundColor = currentColor
        
        
        //get labels in the cell
        let todoTitle = cell.viewWithTag(101) as UILabel
        let todoType = cell.viewWithTag(102) as UILabel
        let todoDate = cell.viewWithTag(103) as UILabel
        
        //set the text of the label
        var todoItem = TodoModel.NSDataToTodo(todoList[indexPath.row])
        todoTitle.text = todoItem.title
        todoType.text = todoItem.type
        todoDate.text = todoItem.date
        
        return cell
    }
    
    //MARK - UITableViewDelegate
    //move items
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    
//    上下调整
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let currentDefault = NSUserDefaults.standardUserDefaults()
        if let list = currentDefault.objectForKey("Todo") as? [NSData]{
            var todoList = list
            let todo = todoList.removeAtIndex(sourceIndexPath.row)
            todoList.insert(todo, atIndex: destinationIndexPath.row)
            currentDefault.setObject(todoList, forKey: "Todo")
        }
        self.tableView.reloadData()
        viewDidLoad()
    }
    
    //MARK - UITableViewDelegate
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
//    左滑动删除
    //MARK - UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            //delete current todo item
            todoList.removeAtIndex(indexPath.row)
            
            //update list in user default
            var customerDefault = NSUserDefaults.standardUserDefaults()
            customerDefault.setObject(todoList, forKey: "Todo")
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.reloadData()
        }
    }
    
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
                vc.currentTodoItem = TodoModel.NSDataToTodo(todoList[index.row])
                vc.currentIndex = index.row
            }
        }
    }
}
