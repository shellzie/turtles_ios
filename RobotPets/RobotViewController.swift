//
//  RobotController.swift
//  RobotPets
//
//  Created by dev on 10/8/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class RobotViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var store: PhotoManager!
    private var myTimer: Timer?
    private var timer: DispatchSourceTimer!
    private var flashView = UIView()
    private let systemSoundID: SystemSoundID = 1108

    
    @IBAction func moveForward(sender: UIButton) {
        API.sendNavCommand(parameters:["r_cmd":"Basics:forward"])
    }
    
    @IBAction func moveReverse(sender: UIButton) {
        API.sendNavCommand(parameters:["r_cmd":"Basics:reverse"])
    }
    
    @IBAction func turnLeft(sender: UIButton) {
        API.sendNavCommand(parameters:["r_cmd":"Basics:left"])
    }
    
    @IBAction func turnRight(sender: UIButton) {
        API.sendNavCommand(parameters:["r_cmd":"Basics:right"])
    }

    @IBAction func saveImage(sender: UIButton) {
        
        if ((self.imageView.image) != nil) {
            
            //animate flash confirmation
            UIView.animate(withDuration: 0.08, delay: 0, options: [], animations: {  
                self.flashView.alpha = 1
            }, completion: {
                (finished: Bool) -> Void in
                 UIView.animate(withDuration: 0.08, delay: 0, options: [], animations: {
                        self.flashView.alpha = 0
                    }, completion: nil)
            })
            
            //play shutter sound
            AudioServicesPlaySystemSound (systemSoundID)
            
            //write image to PhotoLibrary
            let dispatchQ = DispatchQueue.global(qos: DispatchQoS.background.qosClass)
            dispatchQ.async {
                UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimationLayer()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(RobotViewController.backgroundFetch), userInfo: nil, repeats: true)
    }
    
    func setupAnimationLayer() {
        flashView = UIView(frame: CGRect.init(x: 0, y: -6, width: imageView.frame.width, height: imageView.frame.height))
        flashView.alpha = 0
        flashView.backgroundColor = UIColor.black
        imageView.addSubview(flashView)
    }
    
    func backgroundFetch() {
        if ((self.tabBarController?.selectedIndex == 0) && (API.isTurtleConnected())) {
            let queue = DispatchQueue.global(qos: DispatchQoS.utility.qosClass)
            queue.async {
                self.getNextFrame()
                DispatchQueue.main.async(execute: {
                    self.imageView.image = self.store.lastPhoto
                })
            }
        }
    }

    func setupPhotoPolling() {
        let myTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(RobotViewController.getNextFrame as (RobotViewController) -> () -> ()), userInfo: nil, repeats: true)
        RunLoop.current.add(myTimer, forMode: RunLoopMode.init(rawValue: "photo"))
    }
 
    func getNextFrame() {
        print("++++++++++++ in getNextFrame")
        self.store.fetchRecentPhoto()

    }
}
