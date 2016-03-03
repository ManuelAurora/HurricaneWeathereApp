//
//  CurrentWeather.swift
//  Hurricane
//
//  Created by Мануэль on 24.02.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather
{
    let _temperature : Int?
    let _humidity    : Int?
    let _precipChance: Int?
    let _summary     : String?
    var _icon        : UIImage? = UIImage(named: "default.png")
    
    init(weatherDictionary: [String : AnyObject]) {
        if let humidityDouble = weatherDictionary["humidity"] as? Double {
            _humidity = Int(humidityDouble * 100)
        } else {
            _humidity = nil
        }
        if let percipChanceDouble = weatherDictionary["precipProbability"] as? Double {
            _precipChance = Int(percipChanceDouble * 100)
        } else {
            _precipChance = nil
        }
        
        _temperature = weatherDictionary["temperature"] as? Int
        _summary     = weatherDictionary["summary"]     as? String
        
        guard let iconString = weatherDictionary["icon"] as? String,
              let icon: Icon  = Icon(rawValue: iconString) else { return }
            (_icon, _) = icon.toImage()
        }
}