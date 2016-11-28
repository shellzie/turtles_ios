//
//  API.swift
//  RobotPets
//
//  Created by dev on 10/15/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import Foundation
import UIKit

let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
}()

struct API {
    #if DEBUG
        static let herokuURL = "http://localhost:3000"
    #else
        static let herokuURL = "https://robot-pets-api.herokuapp.com"
    #endif
    
    private static let turtleURL = "http://benbot.local"
    
    //called from RobotViewController only use method for POST commands because otherwise we wouldn't use NSMutableURLRequest (for GET we use NSURLRequest)
    static func sendNavCommand(parameters: [String:String]?) {
        let components = NSURLComponents(string: turtleURL + "/robot.py")!
        var queryItems = [NSURLQueryItem]()
        if let queryParams = parameters {
            for (key, value) in queryParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems as [URLQueryItem]?
        let url = components.url! as NSURL
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> () in
            print("++++++++++++++++++ Response is \(response) ")
            print("++++++++++++++++++ Error is \(error) ")
            print("++++++++++++++++++ Data is \(data) ")
        }
        task.resume()
    }

    static func cameraURL() -> NSURL? {
        let urlString = turtleURL + "/motion/robotView.jpg"
        let url = NSURL(string: urlString)
        return url
    }
    
    static func isTurtleConnected()->Bool{
        
        let url = NSURL(string: turtleURL + "/robot.py")
        let request = NSMutableURLRequest(url: url as! URL)
        request.httpMethod = "HEAD"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 10.0
        
        var result:Bool = false
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> () in
            if (response == nil) {
                result = false
            }
            else {
                let resp = response as! HTTPURLResponse
                result = (resp.statusCode == 200)
            }
            
            print("++++++++++++++++++ Response is \(response) ")
            print("++++++++++++++++++ Error is \(error) ")
            print("++++++++++++++++++ Data is \(data) ")
        }
        task.resume()
        print("istutrltconnection returned " + result.description)
        return result
    }
    
}
