//
//  TodayCourseViewController.swift
//  My Day
//
//  Created by MarK on 6/7/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class TodayCourseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var todayCourse = [CourseInfoModel]()
    var amCourseNum = 0;
    var pmCourseNum = 0;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        todayCourse = [CourseInfoModel]()
        
        tableView.reloadData()
        
//        tableView.backgroundView?.backgroundColor = UIColor(patternImage: UIImage(named: "courseBackground")!)
//        self.loadData()
    }
    
    func loadData() {
        amCourseNum = 0;
        pmCourseNum = 0;
        todayCourse = [CourseInfoModel]()
        let userDefault = NSUserDefaults.standardUserDefaults()
        //        userDefault.removeObjectForKey("course")
        if let list = userDefault.objectForKey("course") as? [NSData] {
            
            //Get today date
            let date = NSDate()
            let weekInt = date.dayOfWeek()
            var courseIndex = 0
            if weekInt == 0{
                //Today is Sun. search for index 6
                courseIndex = 6
                
            }else{
                //Today is not Sun. search for index weekInt-1
                courseIndex = weekInt - 1
            }
            
            for var i = 0; i < 5; ++i {
                var tempCourse = CourseInfoModel.NSDataToCourse(list[courseIndex + i * 7])
                todayCourse.append(tempCourse)
            }
        }
        else {
            for var i = 0; i < 5; ++i {
                todayCourse.append(CourseInfoModel())
            }
        }
        
        for var i=0; i<2; ++i {
            if todayCourse[i].isTaken {
                println(todayCourse[i].courseName)
                amCourseNum++
            }
        }
        
        if amCourseNum == 0{
            amCourseNum = 1
        }
        
        for var i = 2; i < 5; ++i {
            if todayCourse[i].isTaken {
                pmCourseNum++
                println(todayCourse[i].courseName)
            }
        }
        
        if pmCourseNum == 0 {
            pmCourseNum = 1
        }
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
        
        var nav = self.navigationController?.navigationBar

//        nav?.barStyle = UIBarStyle.Default
        nav?.backgroundColor = UIColor.whiteColor()
        nav?.tintColor = UIColor.blackColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
//        nav?.setBackgroundImage(UIImage(named: "courseBackground"), forBarMetrics: UIBarMetrics.Default)
        nav?.hidden = true
        
//        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "courseBackground")!)
        
        
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return amCourseNum + pmCourseNum + 2
//        println(todayCourse.count)
        return todayCourse.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        return self.loadData(tableView, cellForRowAtIndexPath: indexPath)
        
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
//        return 50
//    }
    
    func loadData(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell
    {
        let timeCell = tableView.dequeueReusableCellWithIdentifier("TimeCell") as! UITableViewCell
        let courseCell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as! UITableViewCell
        let noCourseCell = tableView.dequeueReusableCellWithIdentifier("NoCourseCell") as! UITableViewCell
        
//        println(courseCell)
        
        
//        let tCell = self.view.viewWithTag(999)?.viewWithTag(1001)
//        let cCel = self.view.viewWithTag(999)?.viewWithTag(1002)
//        let noCell = tableView.viewWithTag(1003)
        
        //today week
        var date = NSDate().dayOfWeek()
        var dateStr = ""
        switch date{
        case 0: dateStr = "星期日"
        case 1: dateStr = "星期一 "
        case 2: dateStr = "星期二"
        case 3: dateStr = "星期三"
        case 4: dateStr = "星期四"
        case 5: dateStr = "星期五"
        case 6: dateStr = "星期六"
        default: dateStr = "星期八"
        }
//        timeCell.frame.size.height = 10
//        timeCell.hidden = true
//        noCourseCell.hidden = true
//        courseCell.frame.size.height = 60
//        noCourseCell.frame.size.height = 10
        

        var courseCellBackground = UIImageView(frame: CGRect(x: courseCell.frame.origin.x+20, y: courseCell.frame.origin.y+5, width: courseCell.frame.size.width-20, height: courseCell.frame.size.height-10))
        courseCellBackground.backgroundColor = UIColor.orangeColor()
        courseCellBackground.layer.cornerRadius = 10
        courseCellBackground.alpha = 0.3
        courseCell.addSubview(courseCellBackground)

        
        if indexPath.row == 0 {
            var label = timeCell.viewWithTag(101) as! UILabel
            label.text = "上午"
            return timeCell
        }else if indexPath.row <= amCourseNum && indexPath.row > 0 {
            if amCourseNum == 1{
                if todayCourse[0].isTaken{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[0].courseName
                    coursePlace.text = todayCourse[0].coursPlace
//                    courseTime.text = dateStr + "  第一、二节"
                    courseTime.text = "1~2节:  08:00 ~ 09:40"
                    return courseCell
                }else if todayCourse[1].isTaken{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[1].courseName
                    coursePlace.text = todayCourse[1].coursPlace
//                    courseTime.text = dateStr + "  第三、四节"
                    courseTime.text = "3~4节:  10:00 ~ 11:40"
                    return courseCell
                }else{
                    var label = noCourseCell.viewWithTag(101) as! UILabel
                    label.text = "今天是" + dateStr + "\n上午没有课，换个心情休息一下"
                    return noCourseCell
                }
            }else{
                if indexPath.row == 1{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[0].courseName
                    coursePlace.text = todayCourse[0].coursPlace
//                    courseTime.text = dateStr + "  第一、二节"
                    courseTime.text = "1~2节:  08:00 ~ 09:40"
                    return courseCell
                }else{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[1].courseName
                    coursePlace.text = todayCourse[1].coursPlace
//                    courseTime.text = dateStr + "  第三、四节"
                    courseTime.text = "3~4节:  10:00 ~ 11:40"
                    return courseCell
                }
            }
        }else if indexPath.row == amCourseNum + 1 {
            var label = timeCell.viewWithTag(101) as! UILabel
            label.text = "下午"
            return timeCell
        }else{
            if pmCourseNum == 1{
                if todayCourse[2].isTaken{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[2].courseName
                    coursePlace.text = todayCourse[2].coursPlace
//                    courseTime.text = dateStr + "  第五、六节"
                    courseTime.text = "5~6节:  13:30 ~ 15:05"
                    return courseCell
                }else if todayCourse[3].isTaken{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[3].courseName
                    coursePlace.text = todayCourse[3].coursPlace
//                    courseTime.text = dateStr + "  第七、八节"
                    courseTime.text = "7~8节:  15:25 ~ 17:00"
                    return courseCell
                }else if todayCourse[4].isTaken{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[4].courseName
                    coursePlace.text = todayCourse[4].coursPlace
//                    courseTime.text = dateStr + "  第九十十一节"
                    courseTime.text = "9~10节:  18:30 ~ 20:10"
                    return courseCell
                }else{
                    var label = noCourseCell.viewWithTag(101) as! UILabel
                    label.text = "今天是" + dateStr + "\n下午没有课，换个心情休息一下"
                    return noCourseCell
                }
            }else if pmCourseNum == 2{
                
                if todayCourse[2].isTaken && todayCourse[3].isTaken{
                    if indexPath.row == amCourseNum + 2{
                        var courseName = courseCell.viewWithTag(101) as! UILabel
                        var coursePlace = courseCell.viewWithTag(102) as! UILabel
                        var courseTime = courseCell.viewWithTag(103) as! UILabel
                        courseName.text = todayCourse[2].courseName
                        coursePlace.text = todayCourse[2].coursPlace
//                        courseTime.text = dateStr + "  第五、六节"
                    courseTime.text = "5~6节:  13:30 ~ 15:05"
                        return courseCell
                    }else{
                        var courseName = courseCell.viewWithTag(101) as! UILabel
                        var coursePlace = courseCell.viewWithTag(102) as! UILabel
                        var courseTime = courseCell.viewWithTag(103) as! UILabel
                        courseName.text = todayCourse[3].courseName
                        coursePlace.text = todayCourse[3].coursPlace
//                        courseTime.text = dateStr + "  第七、八节"
                    courseTime.text = "7~8节:  15:25 ~ 17:00"
                        return courseCell
                    }
                }else if todayCourse[3].isTaken && todayCourse[4].isTaken{
                    if indexPath.row == amCourseNum + 2{
                        var courseName = courseCell.viewWithTag(101) as! UILabel
                        var coursePlace = courseCell.viewWithTag(102) as! UILabel
                        var courseTime = courseCell.viewWithTag(103) as! UILabel
                        courseName.text = todayCourse[2].courseName
                        coursePlace.text = todayCourse[2].coursPlace
//                        courseTime.text = dateStr + "  第七、八节"
                    courseTime.text = "7~8节:  15:25 ~ 17:00"
                        return courseCell
                    }else{
                        var courseName = courseCell.viewWithTag(101) as! UILabel
                        var coursePlace = courseCell.viewWithTag(102) as! UILabel
                        var courseTime = courseCell.viewWithTag(103) as! UILabel
                        courseName.text = todayCourse[3].courseName
                        coursePlace.text = todayCourse[3].coursPlace
//                        courseTime.text = dateStr + "  第九十十一节"
                    courseTime.text = "9~10节:  18:30 ~ 20:10"
                        return courseCell
                    }
                }else{
                    if indexPath.row == amCourseNum + 2{
                        var courseName = courseCell.viewWithTag(101) as! UILabel
                        var coursePlace = courseCell.viewWithTag(102) as! UILabel
                        var courseTime = courseCell.viewWithTag(103) as! UILabel
                        courseName.text = todayCourse[2].courseName
                        coursePlace.text = todayCourse[2].coursPlace
//                        courseTime.text = dateStr + "  第五、六节"
                    courseTime.text = "5~6节:  13:30 ~ 15:05"
                        return courseCell
                    }else{
                        var courseName = courseCell.viewWithTag(101) as! UILabel
                        var coursePlace = courseCell.viewWithTag(102) as! UILabel
                        var courseTime = courseCell.viewWithTag(103) as! UILabel
                        courseName.text = todayCourse[3].courseName
                        coursePlace.text = todayCourse[3].coursPlace
//                        courseTime.text = dateStr + "  第九十十一节"
                    courseTime.text = "9~10节:  18:30 ~ 20:10"
                        return courseCell
                    }
                }
                
            }else{
                if indexPath.row == amCourseNum + 2{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[2].courseName
                    coursePlace.text = todayCourse[2].coursPlace
//                    courseTime.text = dateStr + "  第五、六节"
                    courseTime.text = "5~6节:  13:30 ~ 15:05"
                    return courseCell
                }else if indexPath.row == amCourseNum + 3{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[3].courseName
                    coursePlace.text = todayCourse[3].coursPlace
//                    courseTime.text = dateStr + "  第七、八节"
                    courseTime.text = "7~8节:  15:25 ~ 17:00"                    
                    return courseCell
                }else{
                    var courseName = courseCell.viewWithTag(101) as! UILabel
                    var coursePlace = courseCell.viewWithTag(102) as! UILabel
                    var courseTime = courseCell.viewWithTag(103) as! UILabel
                    courseName.text = todayCourse[4].courseName
                    coursePlace.text = todayCourse[4].coursPlace
//                    courseTime.text = dateStr + "  第九十十一节"
                    courseTime.text = "9~10节:  18:30 ~ 20:10"
                    return courseCell
                }
            }
        }
    }
    @IBAction func showWholeWeekCourses(sender: UIBarButtonItem) {
        var wholeWeekCourseView = self.storyboard?.instantiateViewControllerWithIdentifier("wholeWeekCourseViewController") as! WholeWeekCourseViewController
        self.navigationController?.pushViewController(wholeWeekCourseView, animated: false)
    }
    @IBAction func showWholeWeekCourse(sender: UIButton) {
        var wholeWeekCourseView = self.storyboard?.instantiateViewControllerWithIdentifier("wholeWeekCourseViewController") as! WholeWeekCourseViewController
        self.navigationController?.pushViewController(wholeWeekCourseView, animated: false)
    }
    
}



extension NSDate{
    
    // 0 for Sun. 6 for Sat.
    func dayOfWeek() -> Int {
        var interval = self.timeIntervalSince1970;
        var days = Int(interval / 86400);
        return (days - 3) % 7;
    }
}