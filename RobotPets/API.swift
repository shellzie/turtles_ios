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
    
    private static let herokuURLString = "http://localhost:3000/ios_validate"
    //"https://secret-brushlands-1127.herokuapp.com/users"
    private static let baseURLString = "http://benbot.local/robot.py"
    
    //called from RobotViewController only use method for POST commands because otherwise we wouldn't use NSMutableURLRequest (for GET we use NSURLRequest)
    static func sendPostCommand(parameters: [String:String]?, urlOption: String) {
 
        var components = NSURLComponents.init()
        if (urlOption == "turtle") {
            components = NSURLComponents(string: baseURLString)!
        }
        else if (urlOption == "app") {
            components = NSURLComponents(string: herokuURLString)!
        }
        
        /*
        var queryItems = [NSURLQueryItem]()
        if let queryParams = parameters {
            for (key, value) in queryParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems as [URLQueryItem]?
        */
        
        
        var paramString = ""
        for (key, value) in parameters! {
            let pair = key + "=" + value + "&"
            paramString += pair
        }
        
        //components.queryItems = queryItems as [URLQueryItem]?
        
        //var bodyData = "key1=value&key2=value&key3=value"
        
        
        let url = components.url! as NSURL
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = paramString.data(using: String.Encoding.utf8);
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            print("++++++++++++++++++ Response is \(response) ")
            print("++++++++++++++++++ Error is \(error) ")
            print("++++++++++++++++++ Data is \(data) ")

        }
        task.resume()
    }
    
    static func cameraURL() -> NSURL? {
        let urlString = "http://benbot.local/motion/robotView.jpg"
        let url = NSURL(string: urlString)
        return url
    }



}
