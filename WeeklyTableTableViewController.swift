//
//  WeeklyTableTableViewController.swift
//  Hurricane
//
//  Created by Мануэль on 02.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import UIKit

class WeeklyTableTableViewController: UITableViewController
{
    @IBOutlet weak var _currentTempLabel:      UILabel!
    @IBOutlet weak var _curentPercipLabel:     UILabel!
    @IBOutlet weak var _currentTempRangeLabel: UILabel!
    @IBOutlet weak var _currentWeatherIcon:    UIImageView!
    
    private let _forecastAPIKey = "93d2e057f3fa4c7b1ce50cc14fcc56e6"
    
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)
    
    var _weeklyWeather: [DailyWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        retrieveWeatherForecast()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return _weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell")!
        let dailyWeather = _weeklyWeather[indexPath.row]
        cell.textLabel!.text = dailyWeather._day
        
        return cell
    }
    
    func configureView() {
        tableView.backgroundView = BackgroundView()
        
        let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        let navBarAttributesDictionary: [String : AnyObject] = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName:            navBarFont!
        ]
        
        navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
    }
    
    // MARK: WEATHER FETCHING
    
    func retrieveWeatherForecast() {
        let forecastService = ForecastService(APIKey: _forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) {
            (let forecast) in
            guard let weatherForecast = forecast,
                  let currentWeather = weatherForecast._currentWeather  else { return }
            
            dispatch_async(dispatch_get_main_queue()) {
                if let icon          = currentWeather._icon         { self._currentWeatherIcon.image = icon }
                if let temperature   = currentWeather._temperature  { self._currentTempLabel.text = "\(temperature)°" }
                if let percipitation = currentWeather._precipChance { self._curentPercipLabel.text = "Rain: \(percipitation)%" }
            }
            
            self._weeklyWeather = weatherForecast._weekly
            
            if let highTemp = self._weeklyWeather.first?._maxTemperature,
                let lowTemp = self._weeklyWeather.first?._minTemperature {
                    self._currentTempRangeLabel.text = "↑\(highTemp)° ↓\(lowTemp)°"
            }
            self.tableView.reloadData()
        }
    }
}
