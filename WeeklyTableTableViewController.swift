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
    
    @IBAction func refreshWeather() {
        retrieveWeatherForecast()
        refreshControl?.endRefreshing()
    }
    
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
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Forecast"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return _weeklyWeather.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! DailyWeatherTableViewCell
        let dailyWeather = _weeklyWeather[indexPath.row]
        
        if let maxTemp = dailyWeather._maxTemperature {
            cell._dayLabel.text         = dailyWeather._day
            cell._temperatureLabel.text = "\(maxTemp)"
            cell._weatherIcon.image     = dailyWeather._icon
        }
        
        return cell
    }
    
    func configureView() {
        tableView.backgroundView = BackgroundView()
        
        tableView.rowHeight = 64
        
        let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0)
        let navBarAttributesDictionary: [String : AnyObject] = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName:            navBarFont!
        ]
        
        navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
        
        // Position refresh control above background view
        refreshControl?.layer.zPosition = tableView.backgroundView!.layer.zPosition + 1
        refreshControl?.tintColor = UIColor.whiteColor()
        
    }
    
    // MARK: - Delegate Methods
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 170/255.0, green: 131/255.0, blue: 224/255.0, alpha: 1.0)
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 14.0)
            header.textLabel?.textColor = UIColor.whiteColor()
        }
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        cell?.contentView.backgroundColor = UIColor(red: 165/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
        
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor(red: 165/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
        cell?.selectedBackgroundView = highlightView
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
