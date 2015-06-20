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
    
//    不为空是编辑，为空是新增
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
//    return关掉
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //close the keyboard
//    空白关掉
//    override func  touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
//        itemType.resignFirstResponder()
//        itemTitle.resignFirstResponder()
//    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        itemType.resignFirstResponder()
        itemTitle.resignFirstResponder()

    }
//
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newLength = count(textField.text.utf16) + count(string.utf16) - range.length
        return newLength <= 25 // Bool
    }
    
    //create action
//    确定按钮操作
    @IBAction func createDidClicked(sender: AnyObject) {
        
        let uuid = NSUUID().UUIDString
//        println(uuid)
        
//        根据当前时区取
        let locale = NSLocale.currentLocale()
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("yyyy/MM/dd", options: 0, locale: locale)
        let dateFormmatter = NSDateFormatter()
        dateFormmatter.dateFormat = dateFormat
        
        let time: String = dateFormmatter.stringFromDate(itemDate.date)

        let title = itemTitle.text
        let type = itemType.text
        let currentDefault = NSUserDefaults.standardUserDefaults()
        
        
//        新建
        if currentTodoItem == nil{
            
            //create todo item
            var todoItem = TodoModel()
            todoItem.id = uuid
            todoItem.title = title
            todoItem.type = type
            todoItem.date = time
            todoItem.completed = false
            
            if let list = currentDefault.valueForKey("Todo") as? [NSData] {
                
                var todoList = list
                todoList.append(todoItem.todoToNSData()!)
                
                currentDefault.setObject(todoList, forKey: "Todo")
                
            }
        }
//        编辑
        else{
            
            //edit todo item
            if let list = currentDefault.valueForKey("Todo") as? [NSData] {
                
                var todoList = list
                var tempTodo: TodoModel = TodoModel.NSDataToTodo(todoList[currentIndex!])
                tempTodo.title = title
                tempTodo.type = type
                tempTodo.date = time
                tempTodo.completed = false
                let tempData: NSData? = tempTodo.todoToNSData()
                todoList[currentIndex!] = tempData!
    
                
                currentDefault.setObject(todoList, forKey: "Todo")
            }
        }
        
        
        
        
    }


}
