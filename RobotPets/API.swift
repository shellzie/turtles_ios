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
    
    static let herokuURLString = "http://localhost:3000"  //"https://secret-brushlands-1127.herokuapp.com"
    private static let baseURLString = "http://benbot.local/robot.py"
    
    //called from RobotViewController only use method for POST commands because otherwise we wouldn't use NSMutableURLRequest (for GET we use NSURLRequest)
    static func sendNavCommand(parameters: [String:String]?) {
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
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> () in
            print("++++++++++++++++++ Response is \(response) ")
            print("++++++++++++++++++ Error is \(error) ")
            print("++++++++++++++++++ Data is \(data) ")
        }
        task.resume()
    }
    
    //called from RobotViewController only use method for POST commands because otherwise we wouldn't use NSMutableURLRequest (for GET we use NSURLRequest)
//    static func queryDatabase(parameters: [String:String]?) {
//        let components = NSURLComponents(string: herokuURLString)
//        var paramString = ""
//        for (key, value) in parameters! {
//            let pair = key + "=" + value + "&"
//            paramString += pair
//        }
//        let url = components?.url
//        let request = NSMutableURLRequest(url: url! as URL)
//        request.httpMethod = "POST"
//        request.httpBody = paramString.data(using: String.Encoding.utf8);
//        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> () in
//            print("++++++++++++++++++ Response is \(response) ")
//            print("++++++++++++++++++ Error is \(error) ")
//            print("++++++++++++++++++ Data is \(data) ")
//            
//            if (response.statusCode >= 200 && response.statusCode < 300) {
//                
//            }
//            else if
//        
//        }
//        task.resume()
//    }
    

    static func cameraURL() -> NSURL? {
        let urlString = "http://benbot.local/motion/robotView.jpg"
        let url = NSURL(string: urlString)
        return url
    }
}
