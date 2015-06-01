//
//  AddTodoItemUIViewController.swift
//  My Day
//
//  Created by MarK on 5/31/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class AddTodoItemUIViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var itemTitle: UITextField!
    @IBOutlet weak var itemType: UITextField!
    @IBOutlet weak var itemDate: UIDatePicker!
    
    var currentTodoItem: TodoModel?
    var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTitle.delegate = self
        itemType.delegate = self
        
        
        if currentTodoItem == nil{
            //create todo item
        }else{
            
            //edit todo item
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "MM/dd/yyyy"
            let dateTime = currentTodoItem!.date
            let date = dateFormat.dateFromString(dateTime!)
            
            itemTitle.text = currentTodoItem?.title
            itemType.text = currentTodoItem?.type
            itemDate.date = date!
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //close the keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //close the keyboard
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        itemType.resignFirstResponder()
        itemTitle.resignFirstResponder()
    }
    
    
    //create action
    @IBAction func createDidClicked(sender: AnyObject) {
        
        let uuid = NSUUID().UUIDString
        
        let locale = NSLocale.currentLocale()
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy/MM/dd", options: 0, locale: locale)
        let dateFormmatter = NSDateFormatter()
        dateFormmatter.dateFormat = dateFormat
        
        let time: String = dateFormmatter.stringFromDate(itemDate.date)

        let title = itemTitle.text
        let type = itemType.text
        let currentDefault = NSUserDefaults.standardUserDefaults()
        
        
        if currentTodoItem == nil{
            
            //create todo item
            var todoItem = TodoModel()
            todoItem.id = uuid
            todoItem.title = title
            todoItem.type = type
            todoItem.date = time
            
            if let list = currentDefault.valueForKey("Todo") as? [NSData] {
                
                var todoList = list
                todoList.append(todoItem.todoToNSData()!)
                
                currentDefault.setObject(todoList, forKey: "Todo")
                
            }
            
        }else{
            
            //edit todo item
            if let list = currentDefault.valueForKey("Todo") as? [NSData] {
                
                var todoList = list
                var tempTodo: TodoModel = TodoModel.NSDataToTodo(todoList[currentIndex!])
                tempTodo.title = title
                tempTodo.type = type
                tempTodo.date = time
                let tempData: NSData? = tempTodo.todoToNSData()
                todoList[currentIndex!] = tempData!
    
                
                currentDefault.setObject(todoList, forKey: "Todo")
                
            }
        }
        
        
        
        
    }


}
