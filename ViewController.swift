//
//  ViewController.swift
//  Hurricane
//
//  Created by Мануэль on 24.02.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var _currentTemperatureLabel  : UILabel!
    @IBOutlet weak var _currentHumidityLabel     : UILabel!
    @IBOutlet weak var _currentPercipitationLabel: UILabel!
    
    
    private let _forecastAPIKey = "93d2e057f3fa4c7b1ce50cc14fcc56e6"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(_forecastAPIKey)")
        let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
       
        //Use NSURLSession API to fetch data
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        //NSURLRequest ibject
        let request = NSURLRequest(URL: forecastURL!)
        
        let dataTask = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            print(data)
            print("I'am on a background thread")
        }
        
        print("I'am on a main thread")
        dataTask.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

