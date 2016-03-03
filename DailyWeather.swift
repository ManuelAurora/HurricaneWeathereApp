//
//  DayliWeather.swift
//  Hurricane
//
//  Created by Мануэль on 03.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeather
{
    let _humidity:       Int?
    let _precipChance:   Int?
    let _maxTemperature: Int?
    let _minTemperature: Int?
    var _day:            String?
    let _summary:        String?
    var _sunsetTime:     String?
    var _sunriseTime:    String?
    var _icon:           UIImage? = UIImage(named: "default.png")
    var _largeIcon:      UIImage? = UIImage(named: "default_large.png")
    
    let _dateFormatter = NSDateFormatter()
    
    init(dailyWeatherDict: [String : AnyObject]) {
        _minTemperature = dailyWeatherDict["temperatureMin"] as? Int
        _maxTemperature = dailyWeatherDict["temperatureMax"] as? Int
        _summary        = dailyWeatherDict["summary"]        as? String        
        
        if let humidityFloat = dailyWeatherDict["humidity"]          as? Double { _humidity     = Int(humidityFloat * 100) } else { _humidity     = nil }
        if let precipChance  = dailyWeatherDict["precipProbability"] as? Double { _precipChance = Int(precipChance * 100) }  else { _precipChance = nil }
        if let iconString    = dailyWeatherDict["icon"]              as? String,
            let iconEnum     = Icon(rawValue: iconString) {
                (_icon, _largeIcon) = iconEnum.toImage()
        }
        if let sunsetDate    = dailyWeatherDict["sunsetTime"]  as? Double { _sunsetTime   = timeStringFromUnixTime(sunsetDate) }  else { _sunsetTime   = nil }
        if let sunriseDate   = dailyWeatherDict["sunriseTime"] as? Double { _sunriseTime  = timeStringFromUnixTime(sunriseDate) } else { _sunriseTime  = nil }
        if let time          = dailyWeatherDict["time"]        as? Double { _day          = dayStringFromTime(time) }
    }
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        
        // Returns date formatted as 12 hour time
        _dateFormatter.dateFormat = "hh:mm a"
        return _dateFormatter.stringFromDate(date)
    }
    
    func dayStringFromTime(time: Double) -> String {
        let date = NSDate(timeIntervalSince1970: time)
        _dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.currentLocale().localeIdentifier)
        _dateFormatter.dateFormat = "EEEE"
        return _dateFormatter.stringFromDate(date)
    }
    
}