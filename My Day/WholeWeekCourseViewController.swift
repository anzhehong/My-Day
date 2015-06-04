//
//  WholeWeekCourseViewController.swift
//  My Day
//
//  Created by FOWAFOLO on 15/6/4.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class WholeWeekCourseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

//    var courses : Dictionary<String, String> = ["math":"A101", "english":"b202"]
//    var courses =  [CourseInfoModel]()
//    var course1 = [CourseInfoModel]
//    course1.courseName = "高等数学"
//    course1.coursePlace = "A101"
//    courses.append(courses1)
    
    
    @IBOutlet weak var courseCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 21
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = courseCollectionView.dequeueReusableCellWithReuseIdentifier("courseCell", forIndexPath: indexPath) as UICollectionViewCell
        var courseNameView = cell.viewWithTag(1) as UILabel
        courseNameView.text = "ddd"
        return cell
    }
    
    var screenBounds = UIScreen.mainScreen().applicationFrame
    
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
