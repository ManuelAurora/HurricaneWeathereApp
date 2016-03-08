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
    @IBOutlet weak var _weatherIcon: UIImageView?
    @IBOutlet weak var _summaryLabel: UILabel?
    @IBOutlet weak var _sunriseTimeLabel: UILabel?
    @IBOutlet weak var _sunsetTimeLabel: UILabel?
    @IBOutlet weak var _lowTemperatureLabel: UILabel?
    @IBOutlet weak var _highTemperatureLabel: UILabel?
    @IBOutlet weak var _percipitationLabel: UILabel?
    @IBOutlet weak var _humidityLabel: UILabel?
    
    var _dailyWeather: DailyWeather? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()       
    }
   
  
    func configureView() {
        if let weather = _dailyWeather {
             // Update UI with information from the data model
            self.title = weather._day
            _weatherIcon?.image     = weather._largeIcon
            _summaryLabel?.text     = weather._summary
            _sunsetTimeLabel?.text  = weather._sunsetTime
            _sunriseTimeLabel?.text = weather._sunriseTime
            
            if let lowTemp = weather._minTemperature,
                let highTemp = weather._maxTemperature,
                let rain = weather._precipChance,
                let humidity = weather._humidity {
                    _lowTemperatureLabel?.text = String(lowTemp)
                    _highTemperatureLabel?.text = String(highTemp)
                    _percipitationLabel?.text = String(rain)
                    _humidityLabel?.text = String(humidity)
            }            
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

