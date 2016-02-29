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
    @IBOutlet weak var _currentWeatherSummary    : UILabel!
    @IBOutlet weak var _refreshButton            : UIButton! 
    @IBOutlet weak var _currentWeatherIcon       : UIImageView!
    @IBOutlet weak var _activityIndicator        : UIActivityIndicatorView!
    
    private let _forecastAPIKey = "93d2e057f3fa4c7b1ce50cc14fcc56e6"
    
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveWeatherForecast()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: _forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) {
            (let currentWeather) in
            guard let currentWeather = currentWeather else { return }
            
            dispatch_async(dispatch_get_main_queue()) {
                if let icon          = currentWeather._icon         { self._currentWeatherIcon.image = icon }
                if let summary       = currentWeather._summary      { self._currentWeatherSummary.text = "\(summary)" }
                if let humidity      = currentWeather._humidity     { self._currentHumidityLabel.text = "\(humidity)%"}
                if let temperature   = currentWeather._temperature  { self._currentTemperatureLabel.text = "\(temperature)°" }
                if let percipitation = currentWeather._precipChance { self._currentPercipitationLabel.text = "\(percipitation)%" }
                self.toggleRefreshAnimation(false)
            }
        }
    }
    
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        retrieveWeatherForecast()
    }
    
    func toggleRefreshAnimation(on: Bool) {
        _refreshButton.hidden = on
        if on {
            _activityIndicator.startAnimating()
        } else {
            _activityIndicator.stopAnimating()
        }
    }
}

