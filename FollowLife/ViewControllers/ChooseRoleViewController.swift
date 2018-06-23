//
//  ChooseRoleViewController.swift
//  FollowLife
//
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit

class ChooseRoleViewController: UIViewController {
    @IBOutlet weak var patientButton: UIButton!
    
    @IBOutlet weak var doctorButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        patientButton.backgroundColor = .clear
        patientButton.layer.cornerRadius = 5
        patientButton.layer.borderWidth = 1
        patientButton.layer.borderColor = UIColor(red:0.42, green:0.80, blue:0.99, alpha:1.0).cgColor
        
        doctorButton.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        // Dispose of any resources that can be recreated.
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
