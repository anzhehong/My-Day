//
//  WholeWeekCourseViewController.swift
//  My Day
//
//  Created by FOWAFOLO on 15/6/4.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class WholeWeekCourseViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{


    var coursesDic = [NSData]()
    var screenBounds = UIScreen.mainScreen().applicationFrame
    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    @IBOutlet weak var courseBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        courseCollectionView.backgroundColor = UIColor(patternImage: UIImage(named: "courseBackground")!)
        courseBackView.backgroundColor = UIColor(patternImage: UIImage(named: "courseBackground")!)

        
//        courseCollectionView.alpha = 1
//        courseCollectionView.alpha = 0.3

        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
       
        //load courses from userDefault
        let userDefault = NSUserDefaults.standardUserDefaults()

        //whether is exsit in userDefault
        if let list = userDefault.objectForKey("course") as? [NSData] {
            //exist, let courseDic = list
            coursesDic = list
        }else{
            //not exist, create a list with length 35
            var courseList = [NSData]()
            for i in 0...34
            {
                var course = CourseInfoModel()
                courseList.append(course.courseToNSData()!)
            }
            coursesDic = courseList
            //add to user default
            userDefault.setObject(courseList, forKey: "course")
        }
        
        //self.initCoursesDic()
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var nav = self.navigationController?.navigationBar
                nav?.barStyle = UIBarStyle.Default
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.brownColor()]
        nav?.setBackgroundImage(UIImage(named: "courseBackground"), forBarMetrics: UIBarMetrics.Default)
        nav?.hidden = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func cellBackColorConfig(cell:UICollectionViewCell, indexPath:NSIndexPath) {
        if CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).isTaken == false{
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "courseNone")!)
            cell.alpha = 0.3
        }
        else if CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).coursPlace.componentsSeparatedByString("A").count > 1 {
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "courseRed")!)
            cell.alpha = 0.75
        }else if CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).coursPlace.componentsSeparatedByString("B").count > 1 {
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "courseGreen")!)
            cell.alpha = 0.75
        }else if CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).coursPlace.componentsSeparatedByString("C").count > 1 {
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "courseGreendark")!)
            cell.alpha = 0.75
        }else if CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).coursPlace.componentsSeparatedByString("D").count > 1 {
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "courseGreenYellow")!)
            cell.alpha = 0.75
        }else if CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).coursPlace.componentsSeparatedByString("F").count > 1 {
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "courseYellow")!)
            cell.alpha = 0.9
        }else if CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).coursPlace.componentsSeparatedByString("济事楼").count > 1 {
            cell.backgroundColor = UIColor.purpleColor()
            cell.alpha = 0.5
        }else {
            cell.backgroundColor = UIColor.orangeColor()
            cell.alpha = 0.75
        }
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = courseCollectionView.dequeueReusableCellWithReuseIdentifier("courseCell", forIndexPath: indexPath) as! UICollectionViewCell
        self.cellBackColorConfig(cell, indexPath: indexPath)


        var courseNameView = cell.viewWithTag(1) as! UILabel
        courseNameView.text = CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).courseName
        var coursePlaceView = cell.viewWithTag(2) as! UILabel
        coursePlaceView.text = "@" + CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).coursPlace
        courseNameView.textColor = UIColor.whiteColor()
        coursePlaceView.textColor = UIColor.whiteColor()
        coursePlaceView.font = UIFont.italicSystemFontOfSize(15)
        
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
//        println("\(indexPath.row)")
        //goto edit page
        var info:AddCourseViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddCourseViewController") as! AddCourseViewController
        info.course = CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row])
        info.currentIndexPath = indexPath.row
        self.navigationController?.pushViewController(info, animated: true)
    }
    
    
    //collectionView appearance
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return coursesDic.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: screenBounds.size.width/7-5, height: screenBounds.size.height/5/1.17)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 5
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 2
    }
    
    
    //goback from subViews
    @IBAction func close(segue: UIStoryboardSegue){
        self.courseCollectionView.reloadData()
        self.viewDidLoad()
    }

}
