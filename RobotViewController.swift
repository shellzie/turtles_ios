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
    //@IBOutlet var saveImage: UIButton?
    var store: PhotoManager!
    
//    @IBOutlet var stopCamera: UIButton?
//    @IBOutlet var hideCamera: UIButton?
    
    private var myTimer: Timer?
    private var timer: DispatchSourceTimer!
    
    @IBAction func moveForward(sender: UIButton) {
        API.sendPostCommand(parameters:["r_cmd":"Basics:forward"])
    }
    
    @IBAction func moveReverse(sender: UIButton) {
        API.sendPostCommand(parameters:["r_cmd":"Basics:reverse"])
    }
    
    @IBAction func turnLeft(sender: UIButton) {
        API.sendPostCommand(parameters:["r_cmd":"Basics:left"])
    }
    
    @IBAction func turnRight(sender: UIButton) {
        API.sendPostCommand(parameters:["r_cmd":"Basics:right"])
    }

    @IBAction func saveImage(sender: UIButton) {
        //freeze camera
        myTimer?.invalidate()
        myTimer = nil
        
        //write image
        let dispatchQ = DispatchQueue.global(qos: DispatchQoS.background.qosClass)
        dispatchQ.async {
            UIImageWriteToSavedPhotosAlbum(self.imageView.image!, nil, nil, nil)
        }
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         //   UIImageWriteToSavedPhotosAlbum(img.image, nil, nil, nil);
        //});
        
        //toggle the "resume" button
        
    }
    
//    @IBAction func stopCamera(sender: UIButton) {
//        myTimer?.invalidate()
//        myTimer = nil
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupPhotoPolling()
//        backgroundFetch()
//        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, )
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(RobotViewController.backgroundFetch), userInfo: nil, repeats: true)

    }
    
    func backgroundFetch() {
        let queue = DispatchQueue.global(qos: DispatchQoS.utility.qosClass)
        queue.async {
            self.getNextFrame()
            
            DispatchQueue.main.async(execute: {
                self.imageView.image = self.store.lastPhoto
            })
//            DispatchQueue.main.async(deadline: DispatchTime.now() + .seconds(5)) {
//                self.imageView.image = self.store.lastPhoto
//            }
        }
    }

    func setupPhotoPolling() {
    
        let myTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(RobotViewController.getNextFrame as (RobotViewController) -> () -> ()), userInfo: nil, repeats: true)
        RunLoop.current.add(myTimer, forMode: RunLoopMode.init(rawValue: "photo"))
//        RunLoop.current.add(timer, forMode: RunLoop.current.currentMode)
    }
 
    func getNextFrame() {
        print("+++++++++++ getNextFrame() was called ++++++++++++")
        self.store.fetchRecentPhoto()
        
//        OperationQueue.main.addOperation {
//            self.imageView.image = self.store.lastPhoto
//        }
    }
}
