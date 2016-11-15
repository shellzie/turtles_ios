//
//  LoginViewController.swift
//  RobotPets
//
//  Created by dev on 11/8/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func isValidEmail(str:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let res = emailTest.evaluate(with: str)
        return res
    }
    
    private func isValidPassword(str:String) -> Bool {
        let trimmed = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let length = trimmed.characters.count
        return (length >= 6)
    }
    
    private func createAlertWindow(titleStr:String, msgStr:String) {
        let alert = UIAlertController(title: titleStr, message:msgStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        self.present(alert, animated: true){}
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        let email:String = self.email.text!
        let password:String = self.password.text!
        
        let trimmedEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (trimmedEmail.isEmpty || password.isEmpty) {
            self.createAlertWindow(titleStr:"Sign In Failed!", msgStr:"Please enter email and password")
        } else if (!self.isValidEmail(str: email)) {
            self.createAlertWindow(titleStr:"Error with Email!", msgStr:"Please enter a valid email address")
        } else if !self.isValidPassword(str: password) {
            self.createAlertWindow(titleStr:"Error with password!", msgStr:"Please enter a password containing at least 6 characters")
        } else {
            let components = NSURLComponents(string: API.herokuURLString + "/ios_login")
            let paramString = "email=\(email)&password=\(password)"
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
                    let prefs:UserDefaults = UserDefaults.standard
                    prefs.set(email, forKey: "EMAIL")
                    prefs.set(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    DispatchQueue.main.async(execute: {
                        self.createAlertWindow(titleStr:"Sign in Failed", msgStr:"Credentials not found")
                    })
                }
            }
            task.resume()
        }
    }
}
