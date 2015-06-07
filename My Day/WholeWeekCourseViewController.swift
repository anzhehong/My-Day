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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = courseCollectionView.dequeueReusableCellWithReuseIdentifier("courseCell", forIndexPath: indexPath) as UICollectionViewCell
//        println(CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).isTaken)
        println(CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).isTaken)
        if CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).isTaken == false
        {
            if indexPath.row == 13{
                        println(indexPath.row)
                        println(CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).isTaken)

            }
            cell.backgroundColor = UIColor.grayColor()
        }

        var courseNameView = cell.viewWithTag(1) as UILabel
        courseNameView.text = CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).courseName
        var coursePlaceView = cell.viewWithTag(2) as UILabel
        coursePlaceView.text = CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).coursPlace
//        println(indexPath.row)
//        println(CourseInfoModel.NSDataToCourse(coursesDic[indexPath.row]).isTaken)
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
//        println("\(indexPath.row)")
        //goto edit page
        var info:AddCourseViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddCourseViewController") as AddCourseViewController
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
        return CGSize(width: screenBounds.size.width/7-5, height: screenBounds.size.height/5)
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
