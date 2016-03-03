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
    
    var _dailyWeather: DailyWeather? {
        didSet {
            configureView()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func configureView() {
        if let weather = _dailyWeather {
            self.title = weather._day
        }
        
        //configure NavBar back button
        let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        let barButtonAttributesDictionary: [String : AnyObject] = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName:            buttonFont!
        ]
        
        UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

