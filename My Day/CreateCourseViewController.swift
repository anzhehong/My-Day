//
//  CreateCourseViewController.swift
//  My Day
//
//  Created by MarK on 6/7/15.
//  Copyright (c) 2015 Fowafolo. All rights reserved.
//

import UIKit

class CreateCourseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var weeks = ["Mon", "Tue", "Wed", "Thur", "Fri", "Sat", "Sun"]
    var classes = ["1--2", "3--4", "5--6", "7--8", "9--11"]
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var courseName: UITextField!
    @IBOutlet weak var coursePlace: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func okDidClicked(sender: AnyObject) {
        
        var myCourse = CourseInfoModel()
        myCourse.courseName = courseName.text
        myCourse.coursPlace = coursePlace.text
        myCourse.isTaken = true
        let weekPos = pickerView.selectedRowInComponent(0);
        let classPos = pickerView.selectedRowInComponent(1);
        let indexPath = classPos * 7 + weekPos;
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        if let list = userDefault.objectForKey("course") as? [NSData] {
            var courseList = list
            courseList[indexPath] = myCourse.courseToNSData()!
            userDefault.setObject(courseList, forKey: "course")
        }
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return weeks.count
        }else{
            return classes.count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0{
            return weeks[row]
        }else{
            return classes[row]
        }
    }
    

}
