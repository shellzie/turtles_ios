//
//  RobotAPI.swift
//  RobotPets
//
//  Created by dev on 10/15/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import Foundation

let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
}()

struct RobotAPI {
    
    private static let baseURLString = "https://secret-brushlands-1127.herokuapp.com"
    
    //called from RobotViewController
    static func sendCommand(method: Method, parameters: [String:String]?) {
 
        let components = NSURLComponents(string: baseURLString)!
        var queryItems = [NSURLQueryItem]()
        
        if let queryParams = parameters {
            for (key, value) in queryParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems as [URLQueryItem]?
        let url = components.url! as NSURL
        let request = NSURLRequest(url: url as URL)
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            print("++++++++++++++++++ Response is \(response) ")
        }
        task.resume()
    }
}
