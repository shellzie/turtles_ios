//
//  RobotAPI.swift
//  RobotPets
//
//  Created by dev on 10/15/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import Foundation
import UIKit


//enum PhotosResult {
//    case Success(Photo)
//    case Failure(Error)
//}

let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config)
}()

//public typealias DataFromURLCompletionClosure = (URLResponse?, NSData?) -> Void


struct RobotAPI {
    
    private static let baseURLString = "https://secret-brushlands-1127.herokuapp.com"
//    static let cameraURL = "http://shellzie.com/app/images/kids.jpeg"
    
//    public typealias DataFromURLCompletionClosure = (URLResponse?, NSData?) -> Void
    
    //called from RobotViewController only use method for POST commands because otherwise we wouldn't use NSMutableURLRequest (for GET we use NSURLRequest)
    
    static func sendPostCommand(parameters: [String:String]?) {
 
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
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            print("++++++++++++++++++ Response is \(response) ")
            print("++++++++++++++++++ Error is \(error) ")
        }
        task.resume()
    }
    
    static func cameraURL() -> NSURL? {
        let urlString = "http://shellzie.com/app/images/kids.jpeg"
        let url = NSURL(string: urlString)
        return url
    }

    

    
    //potentially change this to getPhotoURL() and only return URL
//    static func getNextPhoto() {
////        var queue = NSOperationQueue(). session object we used above did not need a queue instance
//        //let urlString = RobotAPI.baseURLString + "?photo=true"
//        let urlString = "http://shellzie.com/app/images/kids.jpeg"
//        
//        //if let encodeString = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
//            if let url = NSURL(string: urlString) {
//                let request = NSMutableURLRequest(url: url as URL)
//                request.httpMethod = "GET"
//                let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
//                    print("++++++++++++++++++ Response is \(response) ")
//                    print("++++++++++++++++++ Error is \(error) ")
//                }
//                task.resume()
//            }
//        
//        }




}
