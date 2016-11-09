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
            API.sendPostCommand(parameters:["email":email, "password":password], urlOption: "app")
            if ( data != nil ) {
                let res = response as NSHTTPURLResponse!;
            }
        }
    }


}
