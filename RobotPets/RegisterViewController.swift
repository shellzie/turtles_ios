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
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        let email:String = self.email.text!
        let password:String = self.password.text!
        let password_confirmation:String = passwordConfirmation.text!
        
        if (email.isEmpty || password.isEmpty || password_confirmation.isEmpty) {
            let alert = UIAlertController(title: "Sign Up Failed!", message:"Please enter email, password, and password confirmation", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        } else if (!password.isEqual(password_confirmation) ) {
            let alert = UIAlertController(title: "Sign in Failed!", message:"Passwords Don't Match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
            self.present(alert, animated: true){}
        } else {
            //API.queryDatabase(parameters: ["email":email, "password":password, "password_confirmation":password_confirmation])
        }
    }

    @IBAction func goToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
