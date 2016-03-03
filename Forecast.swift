//
//  Forecast.swift
//  Hurricane
//
//  Created by Мануэль on 03.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import Foundation

struct Forecast
{
    var _weekly: [DailyWeather] = []

    var _currentWeather: CurrentWeather?
    
    init?(weatherDicionary: [String : AnyObject]?) {
        guard let currentWeatherDictionary = weatherDicionary?["currently"] as? [String : AnyObject] else { return nil }
        _currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
        
        if let weeklyWeatherArray = weatherDicionary?["daily"]?["data"] as? [[String : AnyObject]] {
            
            for dailyWeather in weeklyWeatherArray {
                let daily = DailyWeather(dailyWeatherDict: dailyWeather)
                _weekly.append(daily)
            }
        }
    }
}