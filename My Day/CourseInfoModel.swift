//
//  CourseInfoModel.swift
//  My Day
//
//  Created by FOWAFOLO on 6/5/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class CourseInfoModel: NSObject,NSCoding {
    var courseName : String?
    var coursPlace : String?
    
    override init(){
        
    }
    
    required init(coder aDecoder: NSCoder) {
        self.courseName = aDecoder.decodeObjectForKey("courseName") as? String
        self.coursPlace = aDecoder.decodeObjectForKey("coursPlace") as? String
        
    }
    
    //在这个方法里指定如何归档对象中的每个实例变量，可以使用encodeObject:forKey方法归档实例变量
    func encodeWithCoder(aCoder: NSCoder) {
        
        if let courseName  = self.courseName{
            aCoder.encodeObject(courseName, forKey: "courseName")
        }
        
        if let coursePlace = self.coursPlace {
            aCoder.encodeObject(coursePlace, forKey: "coursePlace")
        }
    }
    
    
    func todoToNSData()-> NSData?{
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
    class func NSDataToTodo(data: NSData)-> CourseInfoModel{
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as CourseInfoModel
    }

    
}
