//
//  ViewController.swift
//  Web Service Example 2
//
//  Created by Wish Carr on 11/23/16.
//  Copyright © 2016 David Shapiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forecastLabel: UILabel!
    
    //var temperature: Double?
    
    
    //note had the fix bridge file address in Build Settings while enter in text bridge.h in Thinkful instructions (had to make slight modification)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = AFHTTPSessionManager()
        //part 1 (this url not working properly): making the call
        
        manager.get("http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&APPID=66b5968b099a9da177d785964be9f493",
                    parameters: nil,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject:Any?) in
                        if let responseObject = responseObject {
                            print("Response: " + (responseObject as AnyObject).description)
                            //inserted data accessing part here so responseObject is defined
                            
                            var json = JSON(responseObject)
                            if let forecast = json["list"][0]["weather"][0]["description"].string {
                                self.forecastLabel.text = String(forecast)
                            }
                            
                            //changing background based on temperature (not working....)
                            json = JSON(responseObject)
                            if let temperature = json["list"][0]["temp"]["morn"].string {
                            let temp = Double(temperature)
                                if temp! <= 0 {
                                    self.view.backgroundColor = UIColor.blue
                                }
                                else {
                                    self.view.backgroundColor = UIColor.red
                                }
                            
                            }
                            
 
                        }
                    })
                        { (operation:URLSessionDataTask?, error:Error) in print("Error: " + error.localizedDescription) }
        
        //part 2: accessing the data
        
        //using SwiftyJSON
        /*
        let json = JSON(responseObject)
        if let forecast = json["list"][0]["temp"]["morn"].string {
            self.forecastLabel.text = forecast
        }
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//Original url: http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=1&APPID=66b5968b099a9da177d785964be9f493

