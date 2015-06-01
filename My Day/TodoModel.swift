//
//  TodoModel.swift
//  My Day
//
//  Created by MarK on 5/31/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class TodoModel: NSObject, NSCoding {
   
    var id: String?
    var title: String?
    var type: String?
    var date: String?
    
    override init() {
        
    }
//    init(id: String, title: String, type: String, date: String) {
//        self.id = id
//        self.title = title
//        self.type = type
//        self.date = date
//    }
    
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObjectForKey("id") as? String
        self.title = aDecoder.decodeObjectForKey("title") as? String
        self.type = aDecoder.decodeObjectForKey("type") as? String
        self.date = aDecoder.decodeObjectForKey("date") as? String
    }
    
    //在这个方法里指定如何归档对象中的每个实例变量，可以使用encodeObject:forKey方法归档实例变量
    func encodeWithCoder(aCoder: NSCoder) {
        
        if let todoId = self.id{
            aCoder.encodeObject(todoId, forKey: "myCourses")
        }
        
        if let todoTitle = self.title{
            aCoder.encodeObject(todoTitle, forKey: "title")
        }
        
        if let todoType = self.type{
           aCoder.encodeObject(todoType, forKey: "type")
        }
        
        if let todoDate = self.date{
            aCoder.encodeObject(todoDate, forKey: "date")
        }
    }
    
    func populateTodo() {
        self.id = "1"
        self.title = "HelloWorld"
        self.type = "Test"
        self.date = "2015-05-31"
    }
    
    func save(){
        let data = NSKeyedArchiver.archivedDataWithRootObject(self)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "Todo")
    }
    
    func todoToNSData()-> NSData?{
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
    class func NSDataToTodo(data: NSData)-> TodoModel{
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as TodoModel
    }
    
    func clear() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("Todo")
    }
    
    class func loadSaved() -> TodoModel? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("Todo") as? NSData {
            return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? TodoModel
        }
        return nil
    }
}
