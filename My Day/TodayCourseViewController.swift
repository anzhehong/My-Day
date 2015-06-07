//
//  TodayCourseViewController.swift
//  My Day
//
//  Created by MarK on 6/7/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class TodayCourseViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var todayCourse = [CourseInfoModel]()
    var amCourseNum = 0;
    var pmCourseNum = 0;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault = NSUserDefaults.standardUserDefaults()
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
        }else{
            for var i = 0; i < 5; ++i {
                todayCourse.append(CourseInfoModel())
            }
        }
        
        for var i=0; i<2; ++i {
            if todayCourse[i].isTaken {
                amCourseNum++
            }
        }
        
        if amCourseNum == 0{
            amCourseNum = 1
        }
        
        for var i = 2; i < 5; ++i {
            if todayCourse[i].isTaken {
                pmCourseNum++
            }
        }
        
        if pmCourseNum == 0 {
            pmCourseNum = 1
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amCourseNum + pmCourseNum + 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let timeCell = tableView.dequeueReusableCellWithIdentifier("TimeCell") as UITableViewCell
        let courseCell = tableView.dequeueReusableCellWithIdentifier("CourseCell") as UITableViewCell
        let noCourseCell = tableView.dequeueReusableCellWithIdentifier("NoCourseCell") as UITableViewCell
        
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
        
        if indexPath.row == 0 {
            var label = timeCell.viewWithTag(101) as UILabel
            label.text = "AM"
            return timeCell
        }else if indexPath.row <= amCourseNum && indexPath.row > 0 {
            if amCourseNum == 1{
                if todayCourse[0].isTaken{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[0].courseName
                    coursePlace.text = todayCourse[0].coursPlace
                    courseTime.text = dateStr + "  第一、二节"
                    return courseCell
                }else if todayCourse[1].isTaken{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[1].courseName
                    coursePlace.text = todayCourse[1].coursPlace
                    courseTime.text = dateStr + "  第三、四节"
                    return courseCell
                }else{
                    var label = noCourseCell.viewWithTag(101) as UILabel
                    label.text = "上午没有课，换个心情休息一下"
                    return noCourseCell
                }
            }else{
                if indexPath.row == 1{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[0].courseName
                    coursePlace.text = todayCourse[0].coursPlace
                    courseTime.text = dateStr + "  第一、二节"
                    return courseCell
                }else{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[1].courseName
                    coursePlace.text = todayCourse[1].coursPlace
                    courseTime.text = dateStr + "  第三、四节"
                    return courseCell
                }
            }
        }else if indexPath.row == amCourseNum + 1 {
            var label = timeCell.viewWithTag(101) as UILabel
            label.text = "PM"
            return timeCell
        }else{
            if pmCourseNum == 1{
                if todayCourse[2].isTaken{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[2].courseName
                    coursePlace.text = todayCourse[2].coursPlace
                    courseTime.text = dateStr + "  第五、六节"
                    return courseCell
                }else if todayCourse[3].isTaken{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[3].courseName
                    coursePlace.text = todayCourse[3].coursPlace
                    courseTime.text = dateStr + "  第七、八节"
                    return courseCell
                }else if todayCourse[4].isTaken{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[4].courseName
                    coursePlace.text = todayCourse[4].coursPlace
                    courseTime.text = dateStr + "  第九十十一节"
                    return courseCell
                }else{
                    var label = noCourseCell.viewWithTag(101) as UILabel
                    label.text = "下午没有课，换个心情休息一下"
                    return noCourseCell
                }
            }else if pmCourseNum == 2{
                
                if todayCourse[2].isTaken && todayCourse[3].isTaken{
                    if indexPath.row == amCourseNum + 2{
                        var courseName = courseCell.viewWithTag(101) as UILabel
                        var coursePlace = courseCell.viewWithTag(102) as UILabel
                        var courseTime = courseCell.viewWithTag(103) as UILabel
                        courseName.text = todayCourse[2].courseName
                        coursePlace.text = todayCourse[2].coursPlace
                        courseTime.text = dateStr + "  第五、六节"
                        return courseCell
                    }else{
                        var courseName = courseCell.viewWithTag(101) as UILabel
                        var coursePlace = courseCell.viewWithTag(102) as UILabel
                        var courseTime = courseCell.viewWithTag(103) as UILabel
                        courseName.text = todayCourse[3].courseName
                        coursePlace.text = todayCourse[3].coursPlace
                        courseTime.text = dateStr + "  第七、八节"
                        return courseCell
                    }
                }else if todayCourse[3].isTaken && todayCourse[4].isTaken{
                    if indexPath.row == amCourseNum + 2{
                        var courseName = courseCell.viewWithTag(101) as UILabel
                        var coursePlace = courseCell.viewWithTag(102) as UILabel
                        var courseTime = courseCell.viewWithTag(103) as UILabel
                        courseName.text = todayCourse[2].courseName
                        coursePlace.text = todayCourse[2].coursPlace
                        courseTime.text = dateStr + "  第七、八节"
                        return courseCell
                    }else{
                        var courseName = courseCell.viewWithTag(101) as UILabel
                        var coursePlace = courseCell.viewWithTag(102) as UILabel
                        var courseTime = courseCell.viewWithTag(103) as UILabel
                        courseName.text = todayCourse[3].courseName
                        coursePlace.text = todayCourse[3].coursPlace
                        courseTime.text = dateStr + "  第九十十一节"
                        return courseCell
                    }
                }else{
                    if indexPath.row == amCourseNum + 2{
                        var courseName = courseCell.viewWithTag(101) as UILabel
                        var coursePlace = courseCell.viewWithTag(102) as UILabel
                        var courseTime = courseCell.viewWithTag(103) as UILabel
                        courseName.text = todayCourse[2].courseName
                        coursePlace.text = todayCourse[2].coursPlace
                        courseTime.text = dateStr + "  第五、六节"
                        return courseCell
                    }else{
                        var courseName = courseCell.viewWithTag(101) as UILabel
                        var coursePlace = courseCell.viewWithTag(102) as UILabel
                        var courseTime = courseCell.viewWithTag(103) as UILabel
                        courseName.text = todayCourse[3].courseName
                        coursePlace.text = todayCourse[3].coursPlace
                        courseTime.text = dateStr + "  第九十十一节"
                        return courseCell
                    }
                }
                
            }else{
                if indexPath.row == amCourseNum + 2{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[2].courseName
                    coursePlace.text = todayCourse[2].coursPlace
                    courseTime.text = dateStr + "  第五、六节"
                    return courseCell
                }else if indexPath.row == amCourseNum + 3{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[3].courseName
                    coursePlace.text = todayCourse[3].coursPlace
                    courseTime.text = dateStr + "  第七、八节"
                    return courseCell
                }else{
                    var courseName = courseCell.viewWithTag(101) as UILabel
                    var coursePlace = courseCell.viewWithTag(102) as UILabel
                    var courseTime = courseCell.viewWithTag(103) as UILabel
                    courseName.text = todayCourse[4].courseName
                    coursePlace.text = todayCourse[4].coursPlace
                    courseTime.text = dateStr + "  第九十十一节"
                    return courseCell
                }
            }
        }
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