//
//  LeftViewController.swift
//  SwiftSideslipLikeQQ
//
//  Created by JohnLui on 15/4/11.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let titlesDictionary = ["日历", "天气", "课程表", "事务","记账", "2048"]

    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var heightLayoutConstraintOfSettingTableView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.tableFooterView = UIView()
        
        heightLayoutConstraintOfSettingTableView.constant = Common.screenHeight < 500 ? Common.screenHeight * (568 - 221) / 568 : 347
        self.view.frame = CGRectMake(0, 0, 320 * 0.78, Common.screenHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewController = UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController
        
//        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        //选择某一功能之后显示页面
//        viewController.homeViewController.titleOfOtherPages = titlesDictionary[indexPath.row]
//        //具体选哪个
//        viewController.homeViewController.performSegueWithIdentifier("showOtherPages", sender: self)
        
        if indexPath.row == 0 {
            let subViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CalendarHome") as! CalendarViewController
            println("Calendar")
            viewController.homeViewController.navigationController?.pushViewController(subViewController, animated: true)

        }else if indexPath.row == 1 {
            let subViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("WeatherHome") as! WeatherViewController
            println("Calendar")
            viewController.homeViewController.navigationController?.pushViewController(subViewController, animated: true)

            
        }else if indexPath.row == 2 {
            let subViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("todayCourseViewController") as! TodayCourseViewController
            println("Calendar")
            viewController.homeViewController.navigationController?.pushViewController(subViewController, animated: true)

            
        }else if indexPath.row == 3 {
            let subViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("TodoUIViewController") as! TodoUIViewController
            println("Calendar")
            viewController.homeViewController.navigationController?.pushViewController(subViewController, animated: true)

        }else if indexPath.row == 4 {
            var alert = UIAlertView(title: "还没做", message: "敬请期待", delegate: nil, cancelButtonTitle: "好的呀☺️")
            alert.show()
        }else if indexPath.row == 5 {
            var gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("2048Game") as! GameViewController
            viewController.homeViewController.navigationController?.pushViewController(gameViewController, animated: true)
        }
        //选择之后左边的弹回去
        viewController.showHome()
        //cell中高亮取消
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesDictionary.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var imageName:NSString = "leftViewCell" + "\(indexPath.row)"
        let cell = tableView.dequeueReusableCellWithIdentifier(imageName as String, forIndexPath: indexPath) as! UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel!.text = titlesDictionary[indexPath.row]
        return cell
    }
    
    @IBAction func showGestureViewController(sender: AnyObject) {
        let viewController = UIApplication.sharedApplication().keyWindow?.rootViewController as! ViewController
        var ges = self.storyboard?.instantiateViewControllerWithIdentifier("ges") as! GesturePasswordControllerViewController
        viewController.homeViewController.navigationController?.pushViewController(ges, animated: true)
        viewController.showHome()
    }
    

}
