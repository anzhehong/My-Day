//
//  CourseInfoModel.swift
//  My Day
//
//  Created by FOWAFOLO on 6/5/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class CourseInfoModel: NSObject,NSCoding {
    var courseName : String
    var coursPlace : String
    var isTaken :Bool
    
    override init(){
        self.courseName = ""
        self.coursPlace = ""
        self.isTaken = false
    }
    
    required init(coder aDecoder: NSCoder) {
        self.courseName = aDecoder.decodeObjectForKey("courseName") as! String
        self.coursPlace = aDecoder.decodeObjectForKey("coursPlace") as! String
        self.isTaken = aDecoder.decodeObjectForKey("isTaken")as! Bool
    }
    
    //在这个方法里指定如何归档对象中的每个实例变量，可以使用encodeObject:forKey方法归档实例变量
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(courseName, forKey: "courseName")
        aCoder.encodeObject(coursPlace, forKey: "coursPlace")
        aCoder.encodeObject(isTaken,forKey:"isTaken")
    }
    
    
    func courseToNSData()-> NSData?{
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
    class func NSDataToCourse(data: NSData)-> CourseInfoModel{
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! CourseInfoModel
    }

    
}
