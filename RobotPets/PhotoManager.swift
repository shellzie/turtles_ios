//
//  PhotoManager.swift
//  RobotPets
//
//  Created by dev on 10/17/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import Foundation
import UIKit

class PhotoManager {
    
    var lastPhoto: UIImage?
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    //can add this method back when we set up polling maybe?
//    private static func createPhotoObj() -> Photo? {
//        let dateTaken = NSDate() //current time
//        return Photo(dateTaken: dateTaken)
//    }

func fetchRecentPhoto() {
        let url = API.cameraURL()
        let request = NSMutableURLRequest(url: url as! URL)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            print("++++++++++++++++++ Response is \(response) ")
            print("++++++++++++++++++ Error is \(error) ")
            print("++++++++++++++++++ data is \(data) ")
            self.lastPhoto = UIImage(data: data!)
        }
        task.resume()
    }
}
