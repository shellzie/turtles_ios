//
//  ViewController.swift
//  RobotPets
//
//  Created by dev on 11/8/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ _animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:UserDefaults = UserDefaults.init()
        if (prefs.value(forKey: "ISLOGGEDIN") == nil) {
            print("no value set in preferences")
        }
        else {
            let isLoggedIn:Int = prefs.integer(forKey: "ISLOGGEDIN")
            if (isLoggedIn != 1) {
                self.performSegue(withIdentifier: "goto_login", sender: self)
            } else {
                self.usernameLabel.text = prefs.string(forKey: "EMAIL") 
            }
        }
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goto_login", sender: self)
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
}
