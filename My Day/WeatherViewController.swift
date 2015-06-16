//
//  WeatherViewController.swift
//  My Day
//
//  Created by FOWAFOLO on 15/5/30.
//  Copyright (c) 2015年 Fowafolo. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var backgroudImg: UIImageView!
    
//    今日

    @IBOutlet weak var placeLabel: UILabel!

    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    @IBOutlet weak var currentDayAndWeekLabel: UILabel!

    
    @IBOutlet weak var todayTemperatureLabel: UILabel!
    
    @IBOutlet weak var todayWeatherImage: UIImageView!
    
//    @IBOutlet weak var todayWeather: UILabel!
    
    @IBOutlet weak var currentHumidityLabel: UILabel!
    
    @IBOutlet weak var windAndWinpLabel: UILabel!
    
//    未来三天
    @IBOutlet weak var tomorrowWeekLabel: UILabel!
    @IBOutlet weak var tomorrowTemLabel: UILabel!
    @IBOutlet weak var tomorrowWeatherImg: UIImageView!
    
    @IBOutlet weak var tomorrow2WeekLabel: UILabel!
    @IBOutlet weak var tomorrow2TemLabel: UILabel!
    @IBOutlet weak var tomorrow2WeatherImg: UIImageView!
    
    @IBOutlet weak var tomorrow3WeekLabel: UILabel!
    @IBOutlet weak var tomorrow3TemLabel: UILabel!
    @IBOutlet weak var tomorrow3WeatherImg: UIImageView!
    
    
    func weatherImgConfig(imgView:UIImageView,weather:String)
    {
        if weather == "晴" {
            imgView.image = UIImage(named: "sunny")
        }else if weather == "晴转多云" {
            imgView.image = UIImage(named: "cloudy")
        }else if weather.componentsSeparatedByString("雨").count > 1  {
            imgView.image = UIImage(named: "rain")
        }else if weather.componentsSeparatedByString("雪").count > 1 {
            imgView.image = UIImage(named: "snow")
        }else if weather.componentsSeparatedByString("云").count > 1 {
            imgView.image = UIImage(named: "fog")
        }
        else {
            imgView.image = UIImage(named: "wind")
        }
    }
    
    func backgroundImgConfig(weather:String) {
        if weather == "晴" {
            backgroudImg.image = UIImage(named: "sunnyDay")
        }else if weather == "晴转多云" {
            backgroudImg.image = UIImage(named: "cloudyDay")
        }else if weather.componentsSeparatedByString("雨").count > 1  {
            backgroudImg.image = UIImage(named: "rainyDay")
        }else if weather.componentsSeparatedByString("雪").count > 1 {
            backgroudImg.image = UIImage(named: "snowyDay")
        }else if weather.componentsSeparatedByString("云").count > 1 {
            backgroudImg.image = UIImage(named: "cloudyDay")
        }
        else {
            backgroudImg.image = UIImage(named: "wind")
        }
    }
    
    func changeTodayWeather(cityName:AnyObject,week:AnyObject,
        temperatureCurr:AnyObject, days:AnyObject,
        temperatureHigh:AnyObject,temperatureLow:AnyObject,
        humidity:AnyObject,humidityHigh:AnyObject,
        humidityLow:AnyObject,weatherToday:AnyObject,
        wind:AnyObject, winp:AnyObject,
        weatherImgView:UIImageView,weekCurr:AnyObject,
        todayTemperature:AnyObject) {
            placeLabel.text  = cityName as? String
            currentTemperatureLabel.text = temperatureCurr as? String
            currentHumidityLabel.text = humidity as? String
            var dayToday = NSDate()
            var dayTodayFormatter = NSDateFormatter()
            dayTodayFormatter.dateFormat = "MM月dd日"
            var dayTodayStr = dayTodayFormatter.stringFromDate(dayToday)
            currentDayAndWeekLabel.text = "\(dayTodayStr) \(weekCurr)"
            todayTemperatureLabel.text = "\(todayTemperature)"
            windAndWinpLabel.text = "\(wind) \(winp)"
            //            todayWeather.text = weatherToday as? String
            self.weatherImgConfig(weatherImgView, weather: weatherToday as! String)
            self.backgroundImgConfig(weatherToday as! String)
            
    }
    
    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        
        self.loadTodayWeather()
        self.loadFuture3DayWeather()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var nav = self.navigationController?.navigationBar
        nav?.setBackgroundImage(backgroudImg.image, forBarMetrics: UIBarMetrics.Default)
        nav?.barStyle = UIBarStyle.Default
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav?.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadTodayWeather(){
        //今日天气
        var urlToday = NSURL(string: "http://api.k780.com:88/?app=weather.today&weaid=38&&appkey=14248&sign=8f3a3981badca2bc2c0a8193f259f916&format=json")
        var dataToday = NSData(contentsOfURL: urlToday!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
        var jsonToday: AnyObject! = NSJSONSerialization.JSONObjectWithData(dataToday!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        var resultToday: AnyObject! = jsonToday.objectForKey("result")
        
        var daysToday:AnyObject! = resultToday.objectForKey("days")
        var weekToday:AnyObject! = resultToday.objectForKey("week")
        var citynm:AnyObject! = resultToday.objectForKey("citynm")
        var weatherToday:AnyObject! = resultToday.objectForKey("weather")
        //今日的温度
        var temperatureToday:AnyObject! = resultToday.objectForKey("temperature")
        //实时温度
        var temperature_currToday:AnyObject! = resultToday.objectForKey("temperature_curr")
        var temp_highToday:AnyObject! = resultToday.objectForKey("temp_high")
        var temp_lowToday:AnyObject! = resultToday.objectForKey("temp_low")
        //今日湿度
        var humidityToday:AnyObject! = resultToday.objectForKey("humidity")
        var humi_lowToday:AnyObject! = resultToday.objectForKey("humi_low")
        var humi_highToday:AnyObject! = resultToday.objectForKey("humi_high")
        //今日风向风速
        var windToday:AnyObject! = resultToday.objectForKey("wind")
        var winpToday:AnyObject! = resultToday.objectForKey("winp")
        
        //显示今日天气
        changeTodayWeather(citynm, week: weekToday, temperatureCurr: temperature_currToday, days: daysToday, temperatureHigh: temp_highToday, temperatureLow: temp_lowToday, humidity: humidityToday, humidityHigh: humi_highToday, humidityLow: humi_lowToday, weatherToday: weatherToday, wind: windToday, winp: winpToday, weatherImgView: todayWeatherImage,weekCurr:weekToday,todayTemperature:temperatureToday)
    }
    
    
    func changeFuture3Weather(week1:AnyObject,week2:AnyObject,
        week3:AnyObject,temp1:AnyObject,
        temp2:AnyObject,temp3:AnyObject,
        weather1:AnyObject,weather2:AnyObject,
        weather3:AnyObject,
        imgView1:UIImageView,
        imgView2:UIImageView,
        imgView3:UIImageView) {
            tomorrowWeekLabel.text = week1 as?String
            tomorrow2WeekLabel.text = week2 as?String
            tomorrow3WeekLabel.text = week3 as?String
            tomorrowTemLabel.text = temp1 as?String
            tomorrow2TemLabel.text = temp2 as?String
            tomorrow3TemLabel.text = temp3 as?String
            
            self.weatherImgConfig(imgView1, weather: weather1 as! String)
            self.weatherImgConfig(imgView2, weather: weather2 as! String)
            self.weatherImgConfig(imgView3, weather: weather3 as! String)
            
        
    }
    
    
    func loadFuture3DayWeather(){
    
        //未来三天
        var url = NSURL(string: "http://api.k780.com:88/?app=weather.future&weaid=38&&appkey=14248&sign=8f3a3981badca2bc2c0a8193f259f916&format=json")
        var data = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
        var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        var result: NSArray! = json.objectForKey("result") as! NSArray
        
        
        //第一天
        
        var days1: AnyObject! = result[1].objectForKey("days")
        var week1: AnyObject! = result[1].objectForKey("week")
        //最高温度
        var temp_high1: AnyObject! = result[1].objectForKey("temp_high")
        //最低温度
        var temp_low1: AnyObject! = result[1].objectForKey("temp_low")
        //温度
        var temperature1: AnyObject! = result[1].objectForKey("temperature")
        //湿度
        var humidity1: AnyObject! = result[1].objectForKey("humidity")
        //最高湿度
        var humi_high1: AnyObject! = result[1].objectForKey("humi_high")
        //最低湿度
        var humi_low1: AnyObject! = result[1].objectForKey("humi_low")
        //风向
        var wind1: AnyObject! = result[1].objectForKey("wind")
        //风力
        var winp1: AnyObject! = result[1].objectForKey("winp")
        var weather1: AnyObject! = result[1].objectForKey("weather")
        
        
        //第二天
        
        var days2: AnyObject! = result[2].objectForKey("days")
        var week2: AnyObject! = result[2].objectForKey("week")
        //最高温度
        var temp_high2: AnyObject! = result[2].objectForKey("temp_high")
        //最低温度
        var temp_low2: AnyObject! = result[2].objectForKey("temp_low")
        //温度
        var temperature2: AnyObject! = result[2].objectForKey("temperature")
        //湿度
        var humidity2: AnyObject! = result[2].objectForKey("humidity")
        //最高湿度
        var humi_high2: AnyObject! = result[2].objectForKey("humi_high")
        //最低湿度
        var humi_low2: AnyObject! = result[2].objectForKey("humi_low")
        //风向
        var wind2: AnyObject! = result[2].objectForKey("wind")
        //风力
        var winp2: AnyObject! = result[2].objectForKey("winp")
        var weather2: AnyObject! = result[2].objectForKey("weather")
    
        
        //第三天
        
        var days3: AnyObject! = result[3].objectForKey("days")
        var week3: AnyObject! = result[3].objectForKey("week")
        //最高温度
        var temp_high3: AnyObject! = result[3].objectForKey("temp_high")
        //最低温度
        var temp_low3: AnyObject! = result[3].objectForKey("temp_low")
        //温度
        var temperature3: AnyObject! = result[3].objectForKey("temperature")
        //湿度
        var humidity3: AnyObject! = result[3].objectForKey("humidity")
        //最高湿度
        var humi_high3: AnyObject! = result[3].objectForKey("humi_high")
        //最低湿度
        var humi_low3: AnyObject! = result[3].objectForKey("humi_low")
        //风向
        var wind3: AnyObject! = result[3].objectForKey("wind")
        //风力
        var winp3: AnyObject! = result[3].objectForKey("winp")
        var weather3: AnyObject! = result[3].objectForKey("weather")
        
        
        changeFuture3Weather(week1, week2: week2, week3: week3, temp1: temperature1, temp2: temperature2, temp3: temperature3, weather1:weather1 , weather2: weather2, weather3: weather3, imgView1: tomorrowWeatherImg, imgView2: tomorrow2WeatherImg, imgView3: tomorrow3WeatherImg)
    }
    
    @IBAction func shareWeather(sender: UIBarButtonItem) {
        var shareAlert = UIAlertView(title: "分享天气", message: "已成功分享给爷爷奶奶姥姥姥爷爸爸妈妈叔叔婶婶姨姨舅舅姑姑姑父（本功能有待开发☺️）", delegate: self, cancelButtonTitle: "好的")
        shareAlert.show()
    }
    

}
