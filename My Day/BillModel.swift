//
//  BillModel.swift
//  My Day
//
//  Created by FOWAFOLO on 15/6/16.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class BillModel: NSObject, NSCoding{
    
    var id: String?
    var type: String?
    var title: String?
    var cost: Double?
    var time: String?
    
    override init() {
        
    }
    
    
   
    func encodeWithCoder(aCoder: NSCoder){
        if let billId = self.id {
            aCoder.encodeObject(billId, forKey: "id")
        }
        if let billType = self.type {
            aCoder.encodeObject(billType, forKey: "type")
        }
        if let billTitle  = self.title {
            aCoder.encodeObject(billTitle, forKey: "title")
        }
        if let billTime = self.time {
            aCoder.encodeObject(billTime, forKey: "time")
        }
        if let billCost = self.cost {
            aCoder.encodeObject(billCost, forKey: "cost")
        }

    }
    
    required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObjectForKey("id") as? String
        self.type = aDecoder.decodeObjectForKey("type") as? String
        self.title = aDecoder.decodeObjectForKey("title") as? String
        self.time = aDecoder.decodeObjectForKey("time") as? String
        
        self.cost = aDecoder.decodeObjectForKey("cost") as? Double
    }
    
    func billToNSData() -> NSData? {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
    class func NSDataToBill(data: NSData) -> BillModel {
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as! BillModel
    }
    
}
