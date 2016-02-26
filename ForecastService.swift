//
//  ForecastService.swift
//  Hurricane
//
//  Created by Мануэль on 26.02.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import Foundation

struct ForecastService {
    
    let _forecastAPIKey  : String
    let _forecastBaseURL : NSURL?
    
    init(APIKey: String) {
        _forecastAPIKey = APIKey
        _forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(_forecastAPIKey)/")
    }
    
    func getForecast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)) {
        guard let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: _forecastBaseURL) else { return }
        let networkOperation = NetworkOperation(url: forecastURL)
        
        networkOperation.downloadJSONFromURL {
            (let JSONDictionary) in
            let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
            completion(currentWeather)
        }
    }
    
    func currentWeatherFromJSON(jsonDictionary: [String : AnyObject]?) -> CurrentWeather? {
        guard let currentWeatherDictionary = jsonDictionary?["currently"] as? [String : AnyObject] else { return nil }
        return CurrentWeather(weatherDictionary: currentWeatherDictionary)
    }
    
}