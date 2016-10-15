//
//  RobotController.swift
//  RobotPets
//
//  Created by dev on 10/8/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit
import Foundation

class RobotViewController: UIViewController {
    
    @IBAction func moveForward(sender: UIButton) {
        RobotAPI.sendPostCommand(parameters:["direction":"forward", "amount": "8"])
    }
    
    @IBAction func moveReverse(sender: UIButton){
        RobotAPI.sendPostCommand(parameters:["direction":"reverse", "amount": "8"])
    }
    
    @IBAction func turnLeft(sender: UIButton){
        RobotAPI.sendPostCommand(parameters:["direction":"left", "amount": "8"])
    }
    
    @IBAction func turnRight(sender: UIButton){
        RobotAPI.sendPostCommand(parameters:["direction":"right", "amount": "8"])
    }
}
