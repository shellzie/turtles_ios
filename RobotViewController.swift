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
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoManager!
    
    
    @IBAction func moveForward(sender: UIButton) {
        API.sendPostCommand(parameters:["command":"forward", "amount": "8"])
    }
    
    @IBAction func moveReverse(sender: UIButton) {
        API.sendPostCommand(parameters:["command":"reverse", "amount": "8"])
    }
    
    @IBAction func turnLeft(sender: UIButton) {
        API.sendPostCommand(parameters:["command":"left", "amount": "8"])
    }
    
    @IBAction func turnRight(sender: UIButton) {
        API.sendPostCommand(parameters:["command":"right", "amount": "8"])
    }
    
    @IBAction func getNextFrame(sender: UIButton) {
        //API.getNextPhoto()
        print("next frame button was clicked!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPhotoPolling()
    
    }
    
    /*
    class func scheduledTimer(timeInterval ti: TimeInterval,
                              target aTarget: Any,
                              selector aSelector: Selector,
                              userInfo: Any?,
                              repeats yesOrNo: Bool) -> Timer
    */

    private func setupPhotoPolling() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(RobotViewController.getNextFrame as (RobotViewController) -> () -> ()), userInfo: nil, repeats: true)
    }
    
    func getNextFrame() {
        print("+++++++++++ getNextFrame() was called ++++++++++++   ")
        store.fetchRecentPhoto()
        OperationQueue.main.addOperation {
            self.imageView.image = self.store.lastPhoto
        }
    }
}
