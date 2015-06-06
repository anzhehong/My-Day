//
//  WholeWeekCourseViewController.swift
//  My Day
//
//  Created by FOWAFOLO on 15/6/4.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class WholeWeekCourseViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{


    var coursesDic = [CourseInfoModel]()
    var screenBounds = UIScreen.mainScreen().applicationFrame
    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    func initCoursesDic()
    {
        for i in 0...34
        {
            var tempCourse = CourseInfoModel()
            coursesDic.append(tempCourse)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        self.initCoursesDic()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = courseCollectionView.dequeueReusableCellWithReuseIdentifier("courseCell", forIndexPath: indexPath) as UICollectionViewCell
        var courseNameView = cell.viewWithTag(1) as UILabel
        courseNameView.text = coursesDic[indexPath.row].courseName
        var coursePlaceView = cell.viewWithTag(2) as UILabel
        coursePlaceView.text = coursesDic[indexPath.row].coursPlace
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        println("\(indexPath.row)")
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

    

}
