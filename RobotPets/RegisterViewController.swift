//
//  RegisterViewController.swift
//  RobotPets
//
//  Created by dev on 11/8/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var passwordConfirmation: UITextField!
    
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
    
//    func transition(Sender: UIButton!) {
//        let secondViewController:SecondViewController = SecondViewController()
//        
//        self.presentViewController(secondViewController, animated: true, completion: nil)
//        
//    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        let email:String = self.email.text!
        let password:String = self.password.text!
        let password_confirm:String = passwordConfirmation.text!
        
        let trimmedEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (trimmedEmail.isEmpty || password.isEmpty || password_confirm.isEmpty) {
            self.createAlertWindow(titleStr:"Sign In Failed!", msgStr:"Please enter email, password, and comfirm password")
        } else if (!self.isValidEmail(str: email)) {
            self.createAlertWindow(titleStr:"Error with Email!", msgStr:"Please enter a valid email address")
        } else if !self.isValidPassword(str: password) {
            self.createAlertWindow(titleStr:"Error with password!", msgStr:"Please enter a password containing at least 6 characters")
        } else if (password != password_confirm) {
            self.createAlertWindow(titleStr: "Passwords do not match", msgStr: "Please enter the same password twice")
        } else {
            let components = NSURLComponents(string: API.herokuURLString + "/ios_register")
            let paramString = "email=\(email)&password=\(password)&password_confirmation=\(password_confirm)"
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
                    
                    DispatchQueue.main.async(execute: {
                        self.performSegue(withIdentifier: "registration_to_home", sender: self)
                    })
                    
                }
                else {
                    DispatchQueue.main.async(execute: {
                        self.createAlertWindow(titleStr:"Sign in Failed", msgStr:"Could not create user. Unknown error??")
                    })
                }
            }
            task.resume()
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "registration_to_home" {
//            var vc = segue.destinationViewController as! HomeViewController
//            //vc.data = "Data you want to pass"
//            //Data has to be a variable name in your RandomViewController
//        }


    @IBAction func goToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
