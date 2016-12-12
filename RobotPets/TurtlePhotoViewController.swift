//
//  TurtlePhotoViewController.swift
//  RobotPets
//
//  Created by dev on 11/30/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit

class TurtlePhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
//    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openCameraButton(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func openPhotoLibraryButton(sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func saveButt(sender: UIButton) {
//        let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
//        let compressedJPGImage = UIImage(data: imageData!)
//        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
//        
//        let alert = UIAlertController(title: "Wow", message:"Your image has been saved to photo library", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
//        self.present(alert, animated: true){}
//    }

}
