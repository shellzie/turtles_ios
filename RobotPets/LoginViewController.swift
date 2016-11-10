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
        
        if (email.isEmpty || password.isEmpty) {
            let alert = UIAlertController(title: "Sign In Failed!", message:"Please enter email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        } else {
            let components = NSURLComponents(string: API.herokuURLString)
            
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
                    let alert = UIAlertController(title: "Log In Failed!", message:"Credentials not found", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
                    self.present(alert, animated: true){}
                }
            }
            task.resume()
        }
    }
}
