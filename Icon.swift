//
//  Icon.swift
//  Hurricane
//
//  Created by Мануэль on 03.03.16.
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
    
    func toImage() -> (regularIcon: UIImage?, largeIcon: UIImage?) {
        var imageName: String
        
        switch self
        {
        case .Rain:   imageName     = "rain"
        case .Snow:   imageName     = "snow"
        case .Sleet:  imageName     = "sleet"
        case .Wind:   imageName     = "wind"
        case .Fog:    imageName     = "fog"
        case .Cloudy: imageName     = "cloudy"
        case .ClearDay:   imageName = "clear-day"
        case .ClearNight: imageName = "clear-night"
        case .PartlyCloudyDay:   imageName = "cloudy-day"
        case .PartlyCloudyNight: imageName = "cloudy-night"
        }
        
        let regularIcon = UIImage(named: "\(imageName).png")
        let largeIcon   = UIImage(named: "\(imageName)_large.png")
        
        return (regularIcon, largeIcon)
    }
}
