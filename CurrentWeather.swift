//
//  CurrentWeather.swift
//  Hurricane
//
//  Created by Мануэль on 24.02.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String
{
    case Rain       = "rain"
    case Snow       = "snow"
    case Sleet      = "sleet"
    case Wind       = "wind"
    case Fog        = "fog"
    case Cloudy     = "cloudy"
    case ClearDay   = "clear-day"
    case ClearNight = "clear-night"
    case PartlyCloudyDay   = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    func toImage() -> UIImage {
        var imageName: String
        
        switch self
        {
        case .ClearDay  : imageName = "clear-day.png"
        case .ClearNight: imageName = "clear-night.png"
        case .Rain      : imageName = "rain.png"
        case .Snow      :imageName  = "snow.png"
        case .Sleet     :imageName  = "sleet.png"
        case .Wind      :imageName  = "wind.png"
        case .Fog       :imageName  = "fog.png"
        case .Cloudy    :imageName  = "cloudy.png"
        case .PartlyCloudyDay  :imageName = "cloudy-day.png"
        case .PartlyCloudyNight:imageName = "cloudy-night.png"
        }
        
        return UIImage(named: imageName)!
    }
}

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
        
        _icon = icon.toImage()
    }    
}