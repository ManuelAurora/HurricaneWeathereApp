//
//  DayliWeather.swift
//  Hurricane
//
//  Created by Мануэль on 03.03.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import Foundation
import UIKit

struct DayliWeather
{
    let _humidity:       Int?
    let _precipChance:   Int?
    let _maxTemperature: Int?
    let _minTemperature: Int?
    let _day:            String?
    let _summary:        String?
    let _sunsetTime:     String?
    let _sunriseTime:    String?
    var _icon:           UIImage? = UIImage(named: "default.png")
    var _largeIcon:      UIImage? = UIImage(named: "default_large.png")
    
    init(dayliWeatherDict: [String : AnyObject]) {
        _maxTemperature = dayliWeatherDict["temperatureMax"] as? Int
        _summary        = dayliWeatherDict["summary"] as? String
        
        
        if let humidityFloat = dayliWeatherDict["humidity"] as? Double { _humidity = Int(humidityFloat * 100) }
        if let precipChance = dayliWeatherDict["precipProbability"] as? Double { _precipChance = Int(precipChance * 100) }
        if let iconString = dayliWeatherDict["icon"] as? String,
            let iconEnum = Icon(rawValue: iconString) {
                (_icon, _largeIcon) = iconEnum.toImage()
        }
       
        
        
    }
}