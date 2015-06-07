//
//  AddCourseViewController.swift
//  My Day
//
//  Created by MarK on 6/7/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class AddCourseViewController: UIViewController {

    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var courseTime: UITextField!
    @IBOutlet weak var coursePlace: UITextField!
    
    var course: CourseInfoModel?
    var currentIndexPath: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        courseName.text = course?.courseName
        coursePlace.text = course?.coursPlace
        let weekPos = currentIndexPath! % 7
        let classPos = currentIndexPath! / 7 + 1
        // Do any additional setup after loading the view.
        courseTime.text = getCourseTime(weekPos, classPos: classPos)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //ok button clicked
    @IBAction func okDidClicked(sender: UIButton) {
        
        var myCourse = CourseInfoModel()
        myCourse.coursPlace = coursePlace.text
        myCourse.courseName = courseName.text
        if courseName.text != "" && coursePlace.text != "" {
            myCourse.isTaken = true
        }else{
            myCourse.isTaken = false
        }
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        if let list = userDefault.objectForKey("course") as? [NSData] {
            var tempCourseList = list
            tempCourseList[currentIndexPath!] = myCourse.courseToNSData()!
            userDefault.setObject(tempCourseList, forKey: "course")
        }
        
    }
    
    func getCourseTime(weekPos:Int, classPos: Int) ->String{
        var weekStr = "";
        var classStr = "";
        switch weekPos {
        case 0: weekStr = "星期一"
        case 1: weekStr = "星期二"
        case 2: weekStr = "星期三"
        case 3: weekStr = "星期四"
        case 4: weekStr = "星期五"
        case 5: weekStr = "星期六"
        case 6: weekStr = "星期日"
        default: weekStr = "星期八"
        }
        
        switch classPos {
        case 1: classStr = "第一、二节"
        case 2: classStr = "第三、四节"
        case 3: classStr = "第五、六节"
        case 4: classStr = "第七、八节"
        case 5: classStr = "第九十十一节"
        default: classStr = "第n节"
        }
        return weekStr + "  " + classStr;
    }
}
