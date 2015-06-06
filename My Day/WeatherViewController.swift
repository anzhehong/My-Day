//
//  WeatherViewController.swift
//  My Day
//
//  Created by FOWAFOLO on 15/5/30.
//  Copyright (c) 2015年 Fowafolo. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var weatherTextView: UITextView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadToday(sender: AnyObject) {
        self.loadTodayWeather()
    }
    
    @IBAction func loadFuture3(sender: AnyObject) {
        self.loadFuture3DayWeather()
    }

    
    func loadWeather(){
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
        var humidityTodat:AnyObject! = resultToday.objectForKey("humidity")
        var humi_currToday:AnyObject! = resultToday.objectForKey("temp_curr")
        var humi_lowToday:AnyObject! = resultToday.objectForKey("humi_low")
        var humi_highToday:AnyObject! = resultToday.objectForKey("humi_high")
        //今日风向风速
        var windToday:AnyObject! = resultToday.objectForKey("wind")
        var winpToday:AnyObject! = resultToday.objectForKey("winp")
        
        changeTextView(daysToday, week: weekToday, cityName: citynm, weather: weekToday, temperature: temperatureToday, temperatureHigh: temp_highToday, temperatureLow: temp_lowToday, humidity: humidityTodat, humidityHigh: humi_highToday, humidityLow: humi_lowToday, wind: windToday, winp: winpToday)

        
    }
    
    func changeTextView(days:AnyObject, week:AnyObject,
        cityName:AnyObject, weather:AnyObject,
        temperature:AnyObject, temperatureHigh:AnyObject,
        temperatureLow:AnyObject, humidity:AnyObject,
        humidityHigh:AnyObject,humidityLow:AnyObject,
        wind:AnyObject, winp:AnyObject) {
        
        weatherTextView.text = "days:\(days)\nweek:\(week)\ntemperature:\(temperature)\n最高温度：\(temperatureHigh)\n最低温度：\(temperatureLow)\n湿度：\(humidity)"
    }
    
    func loadFuture3DayWeather(){
        
        //未来三天
        var url = NSURL(string: "http://api.k780.com:88/?app=weather.future&weaid=38&&appkey=14248&sign=8f3a3981badca2bc2c0a8193f259f916&format=json")
        var data = NSData(contentsOfURL: url!, options: NSDataReadingOptions.DataReadingUncached, error: nil)
        
        var json: AnyObject! = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        
        var result: NSArray! = json.objectForKey("result") as NSArray
        
        //第一天
        
        var days1: AnyObject! = result[0].objectForKey("days")
        var week1: AnyObject! = result[0].objectForKey("week")
        //最高温度
        var temp_high1: AnyObject! = result[0].objectForKey("temp_high")
        //最低温度
        var temp_low1: AnyObject! = result[0].objectForKey("temp_low")
        //温度
        var temperature1: AnyObject! = result[0].objectForKey("temperature")
        //湿度
        var humidity1: AnyObject! = result[0].objectForKey("humidity")
        //最高湿度
        var humi_high1: AnyObject! = result[0].objectForKey("humi_high")
        //最低湿度
        var humi_low1: AnyObject! = result[0].objectForKey("humi_low")
        //风向
        var wind1: AnyObject! = result[0].objectForKey("wind")
        //风力
        var winp1: AnyObject! = result[0].objectForKey("winp")
        
        //第二天
        
        var days2: AnyObject! = result[1].objectForKey("days")
        var week2: AnyObject! = result[1].objectForKey("week")
        //最高温度
        var temp_high2: AnyObject! = result[1].objectForKey("temp_high")
        //最低温度
        var temp_low2: AnyObject! = result[1].objectForKey("temp_low")
        //温度
        var temperature2: AnyObject! = result[1].objectForKey("temperature")
        //湿度
        var humidity2: AnyObject! = result[1].objectForKey("humidity")
        //最高湿度
        var humi_high2: AnyObject! = result[1].objectForKey("humi_high")
        //最低湿度
        var humi_low2: AnyObject! = result[1].objectForKey("humi_low")
        //风向
        var wind2: AnyObject! = result[1].objectForKey("wind")
        //风力
        var winp2: AnyObject! = result[1].objectForKey("winp")
        
        
        //第三天
        
        var days3: AnyObject! = result[2].objectForKey("days")
        var week3: AnyObject! = result[2].objectForKey("week")
        //最高温度
        var temp_high3: AnyObject! = result[2].objectForKey("temp_high")
        //最低温度
        var temp_low3: AnyObject! = result[2].objectForKey("temp_low")
        //温度
        var temperature3: AnyObject! = result[2].objectForKey("temperature")
        //湿度
        var humidity3: AnyObject! = result[2].objectForKey("humidity")
        //最高湿度
        var humi_high3: AnyObject! = result[2].objectForKey("humi_high")
        //最低湿度
        var humi_low3: AnyObject! = result[2].objectForKey("humi_low")
        //风向
        var wind3: AnyObject! = result[2].objectForKey("wind")
        //风力
        var winp3: AnyObject! = result[2].objectForKey("winp")
    }
    
}
