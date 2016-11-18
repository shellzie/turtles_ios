//
//  PromoViewController.swift
//  RobotPets
//
//  Created by dev on 11/17/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit

class PromoViewController: UIViewController {
    
    @IBOutlet var promo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func isValidPromo(str:String) -> Bool {
        let length = str.characters.count
        return (length >= 4)
    }
    
    private func createAlertWindow(titleStr:String, msgStr:String) {
        let alert = UIAlertController(title: titleStr, message:msgStr, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        self.present(alert, animated: true){}
    }
    
    @IBAction func getStartedTapped(sender: UIButton) {
        let promo:String = self.promo.text!
        
        let trimmedPromo = promo.trimmingCharacters(in: CharacterSet.whitespaces)
        
        if (trimmedPromo.isEmpty) {
            self.createAlertWindow(titleStr:"Uh oh!", msgStr:"Please enter your promo code")
        } else if (!self.isValidPromo(str: trimmedPromo)) {
            self.createAlertWindow(titleStr:"Uh oh!", msgStr:"Please enter a valid promo code")
        } else {
            let components = NSURLComponents(string: API.herokuURLString + "/promo")
            let paramString = "code=\(promo)"
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
                    prefs.set(promo, forKey: "PROMO")
                    prefs.set(1, forKey: "HASPROMO")
                    prefs.synchronize()
                    
                    DispatchQueue.main.async(execute: {
                        self.performSegue(withIdentifier: "promo_to_register", sender: self)
                    })
                }
                else if(resp.statusCode >= 300 && resp.statusCode < 400) {
                    DispatchQueue.main.async(execute: {
                        self.createAlertWindow(titleStr:"Promo Failed", msgStr:"Invalid Code. Error 300-400")
                    })
                }
                else if (resp.statusCode >= 400) {
                    DispatchQueue.main.async(execute: {
                        self.createAlertWindow(titleStr:"Promo Failed", msgStr:"Invalid Code. Error 400+")
                    })
                }
            }
            task.resume()
        }
        
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
