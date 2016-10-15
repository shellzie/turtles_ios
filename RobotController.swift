//
//  RobotController.swift
//  RobotPets
//
//  Created by dev on 10/8/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit
import Foundation

enum Method: String {
    case Post = "POST"
}

class RobotViewController: UIViewController {
    

    @IBAction func moveForward(sender: UIButton) {
        RobotAPI.sendCommand(method: .Post, parameters:["direction":"forward", "amount": "8"])
    }
    
    func moveReverse(by amount: Int){
        RobotAPI.sendCommand(method: .Post, parameters:["direction":"reverse", "amount": "8"])
    }
    
    func turnLeft(by amount: Int){
        RobotAPI.sendCommand(method: .Post, parameters:["direction":"left", "amount": "8"])
    }
    
    func turnRight(by amount: Int){
        RobotAPI.sendCommand(method: .Post, parameters:["direction":"right", "amount": "8"])
    }
}
