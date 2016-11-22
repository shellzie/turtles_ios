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
        let isLoggedIn:Int = prefs.integer(forKey: "ISLOGGEDIN")
        let hasPromo:Int = prefs.integer(forKey: "HASPROMO")
        
        if (hasPromo != 1) {
            self.performSegue(withIdentifier: "goto_promo", sender: self)
        }
        else if (isLoggedIn != 1) {
            self.performSegue(withIdentifier: "goto_register", sender: self)
        } else {
            self.usernameLabel.text = prefs.string(forKey: "EMAIL")
        }
    }
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "goto_login", sender: self)
        })
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
    }
}
