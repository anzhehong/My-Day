//
//  GesturePasswordControllerViewController.swift
//  GesturePassword4Swift
//
//  Created by feiin on 14/11/22.
//  Copyright (c) 2014年 swiftmi. All rights reserved.
//

import UIKit

class GesturePasswordControllerViewController: UIViewController,VerificationDelegate,ResetDelegate,GesturePasswordDelegate {

    var gesturePasswordView:GesturePasswordView!
    
    var previousString:String? = ""
    var password:String? = ""
    
    var secKey:String = "GesturePassword4Swift"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previousString = ""
        password = KeychainWrapper.stringForKey(secKey)
        self.clear()
        
        if( password == "" || password == nil){
            
            self.reset()
        }
        else{
            self.verify()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    //MARK: - 验证手势密码
    func verify(){
        
        gesturePasswordView = GesturePasswordView(frame: UIScreen.mainScreen().bounds)
        gesturePasswordView.tentacleView!.rerificationDelegate = self
        gesturePasswordView.tentacleView!.style = 1
        gesturePasswordView.gesturePasswordDelegate = self
        self.view.addSubview(gesturePasswordView)
        
    }
    
    //MARK: - 重置手势密码
    func reset(){
        
        gesturePasswordView = GesturePasswordView(frame: UIScreen.mainScreen().bounds)
        gesturePasswordView.tentacleView!.resetDelegate = self
        gesturePasswordView.tentacleView!.style = 2
        gesturePasswordView.forgetButton!.hidden = true
         gesturePasswordView.changeButton!.hidden = true
        
        self.view.addSubview(gesturePasswordView)
        
    }
    
    func exist()->Bool{
        
    
        password = KeychainWrapper.stringForKey(secKey)
        if password == "" {
            return false
        }
        return true
    }
    
    //MARK: - 清空记录
    func clear(){
        
        KeychainWrapper.removeObjectForKey(secKey)
    }
    
    //MARK: - 改变手势密码
    func change(){
        
        println("改变手势密码")
        
    }
    
    //MARK: - 忘记密码
    func forget(){
          println("忘记密码")
    }
    
    
    func verification(result:String)->Bool{
        
       // println("password:\(result)====\(password)")
        if(result == password){
            
            gesturePasswordView.state!.textColor = UIColor.whiteColor()
            gesturePasswordView.state!.text = "输入正确"
            
            
//            var rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as! ViewController
//            presentViewController(rootViewController, animated: true, completion: nil)
            self.navigationController?.popToRootViewControllerAnimated(true)
            
            return true
        }
        gesturePasswordView.state!.textColor = UIColor.redColor()
        gesturePasswordView.state!.text = "手势密码错误"
        return false
    }
    
    func resetPassword(result: String) -> Bool {
    
        if(previousString == ""){
            previousString = result
            gesturePasswordView.tentacleView!.enterArgin()
            gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
            gesturePasswordView.state!.text = "请验证输入密码"
            
            return true
        }else{
            
            if(result == previousString){
                
               
              
                 KeychainWrapper.setString(result, forKey: secKey)
                
                gesturePasswordView.state!.textColor = UIColor(red: 2/255, green: 174/255, blue: 240/255, alpha: 1)
                gesturePasswordView.state!.text = "已保存手势密码"
                
//                var rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as! ViewController
//                presentViewController(rootViewController, animated: true, completion: nil)
                self.navigationController?.popToRootViewControllerAnimated(true)
            
                return true;
            }else{
                previousString = "";
                gesturePasswordView.state!.textColor = UIColor.redColor()
                gesturePasswordView.state!.text = "两次密码不一致，请重新输入"
                
                return false
            }
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
