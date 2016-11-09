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
    

    @IBAction func loginTapped(_ sender: UIButton) {
        let email:String = self.email.text!
        let password:String = self.password.text!
        
        if ( email.isEmpty || password.isEmpty) {
            let alert = UIAlertController(title: "Sign In Failed!", message:"Please enter email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        } else {
            let response:HTTPURLResponse = API.sendPostCommand(parameters:["email":email, "password":password], urlOption: "app")
            
            if (response != nil) {
                let responseCode = response.statusCode
                if (responseCode >= 200 && responseCode < 300) {
                    let prefs:UserDefaults = UserDefaults.standard
                    prefs.set(email, forKey: "EMAIL")
                    prefs.set(1, forKey: "ISLOGGEDIN")
                    prefs.synchronize()
                    self.dismiss(animated: true, completion: nil)
                } else {
                    
                    let alert = UIAlertController(title: "Log In Failed!", message:"Credentials not found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self.present(alert, animated: true){}
                }
            } else {
                
                let alert = UIAlertController(title: "Log In Failed!", message:"Connection Failure", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                self.present(alert, animated: true){}
            }
        }
    }
}
