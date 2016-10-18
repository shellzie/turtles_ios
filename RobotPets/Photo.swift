//
//  Photo.swift
//  RobotPets
//
//  Created by dev on 10/17/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit

class Photo {
    
    let dateTaken: NSDate
    var image: UIImage?
    
    init(dateTaken: NSDate) {
        self.dateTaken = dateTaken
    }
}
