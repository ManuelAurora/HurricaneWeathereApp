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
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
            (let currentWeather) in
            guard let currentWeather = currentWeather else { return }
            
            dispatch_async(dispatch_get_main_queue()) {
                if let icon          = currentWeather._icon         { self._currentWeatherIcon.image = icon }
                if let temperature   = currentWeather._temperature  { self._currentTempLabel.text = "\(temperature)°" }
                if let percipitation = currentWeather._precipChance { self._curentPercipLabel.text = "Rain: \(percipitation)%" }
            }
        }
    }
}
