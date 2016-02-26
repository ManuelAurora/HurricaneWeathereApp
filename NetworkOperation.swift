//
//  NetworkOperation.swift
//  Hurricane
//
//  Created by Мануэль on 26.02.16.
//  Copyright © 2016 AuroraInterplay. All rights reserved.
//

import Foundation

class NetworkOperation
{
    lazy var _config = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var _session : NSURLSession = NSURLSession(configuration: self._config)
    
    let _queryURL : NSURL
    
    typealias JSONDictionaryCompletion = ([String : AnyObject]?) -> Void
    
    init(url: NSURL){
        _queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        let request : NSURLRequest = NSURLRequest(URL: _queryURL)
        let dataTask = _session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            //1.Check HTTP response for successful GET request
            guard let httpResponse = response as? NSHTTPURLResponse else { print("Error occured"); return }
            
            switch httpResponse.statusCode
            {
            case 200 :
                //2. Create JSON object with data
                let jsonDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options:  NSJSONReadingOptions.AllowFragments) as? [String : AnyObject]
                completion(jsonDictionary)
                
            default : print("Get request failed. HTTP status code \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
    }
   
}