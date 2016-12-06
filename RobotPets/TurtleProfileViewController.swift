//
//  TurtlePhotoViewController.swift
//  RobotPets
//
//  Created by dev on 11/30/16.
//  Copyright © 2016 Shellzie. All rights reserved.
//

import UIKit

class TurtleProfileViewController: UITableViewController {
    
      override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func showActionSheet(_ sender: Any) {
        
//        let optionMenu = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Take Photo", style: .default)
        let saveAction = UIAlertAction(title: "Choose from Library", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)

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
