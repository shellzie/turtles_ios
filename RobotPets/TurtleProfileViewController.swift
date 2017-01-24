//
//  TurtlePhotoViewController.swift
//  RobotPets
//
//  Created by dev on 11/30/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit

class TurtleProfileViewController: UITableViewController {

    @IBOutlet var bio: UITextField!
    @IBOutlet var hobbies: UITextField!
    @IBOutlet var color: UITextField!
    @IBOutlet var dances: UITextField!
    @IBOutlet var music: UITextField!
    @IBOutlet var phrase: UITextField!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneTapped))
        self.navigationItem.leftBarButtonItem = doneButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    private func isvalidTextField(str:String) -> Bool {
//        
//    }
    
    private func createAlertWindow(titleStr:String, msgStr:String) {
        let alert = UIAlertController(title: titleStr, message:msgStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        self.present(alert, animated: true){}
    }

//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        let bio:String = self.bio.text!
//        let hobbies:String = self.hobbies.text!
//        let color:String = self.color.text!
//        let dances:String = self.dances.text!
//        let music:String = self.music.text!
//        let phrase:String = self.phrase.text!
//        //asci escape all of the above fields (escape spaces and other special chars)
//        //extract info from child view controller like name, birthdate, and photo
//        //validate turtle's name (ie. must be present)
//        //send up user id
//        
//        let components = NSURLComponents(string: API.herokuURL + "/ios_turtle_profile")
//        let paramString = "bio=\(bio)&hobbies=\(hobbies)&color=\(color)&dances=\(dances)&music=\(music)&phrase=\(phrase)"
//        let url = components?.url
//        let request = NSMutableURLRequest(url: url! as URL)
//        request.httpMethod = "POST"
//        request.httpBody = paramString.data(using: String.Encoding.utf8);
//        
//        var result = false
//        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> () in
//            print("++++++++++++++++++ Response is \(response) ")
//            print("++++++++++++++++++ Error is \(error) ")
//            print("++++++++++++++++++ Data is \(data) ")
//            let resp = response as! HTTPURLResponse
//            if (resp.statusCode >= 200 && resp.statusCode < 300) {
//                result = true;
//            }
//            else {
//                result = false;
//            }
//        }
//        task.resume()
//        return result
//    }
// 
    @objc private func doneTapped(sender: UIButton) {
//        let bio:String = self.bio.text!
        let hobbies:String = self.hobbies.text!
        let color:String = self.color.text!
        let dances:String = self.dances.text!
        let music:String = self.music.text!
        let phrase:String = self.phrase.text!
        //asci escape all of the above fields (escape spaces and other special chars)
        
        //extract info from child view controller like name, birthdate, and photo
        
        //validate turtle's name (ie. must be present)
        
        let prefs:UserDefaults = UserDefaults.standard
        let user_email = prefs.value(forKey: "EMAIL")
        
        let name = "michellesturtle4"
        
        
        
        let components = NSURLComponents(string: API.herokuURL + "/ios_turtle_profile")
        let paramString = "name=\(name)&user_email=\(user_email)&hobbies=\(hobbies)&color=\(color)&dances=\(dances)&music=\(music)&phrase=\(phrase)"
        let url = components?.url
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST"
        request.httpBody = paramString.data(using: String.Encoding.utf8);
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) -> () in
            print("++++++++++++++++++ Response is \(response) ")
            print("++++++++++++++++++ Error is \(error) ")
            print("++++++++++++++++++ Data is \(data) ")
            let resp = response as! HTTPURLResponse
            if (resp.statusCode >= 200 && resp.statusCode < 300) {
                print("+++++ SUCCESS+++++")
//                DispatchQueue.main.async(execute: {
//                    self.performSegue(withIdentifier: "turtle_profile_to_home", sender: self)
//                })
            }
            else {
                DispatchQueue.main.async(execute: {
                    self.createAlertWindow(titleStr:"Error in Turtle Profile Creation", msgStr:"Error greater than 300 or less than 200")
                })
            }
        }
        task.resume()
        

    }
}
