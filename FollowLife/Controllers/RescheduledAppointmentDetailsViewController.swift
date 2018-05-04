//
//  rescheduledAppointmentDetailsViewController.swift
//  FollowLife
//
//  Created by Hillari Zorrilla Delgado on 5/2/18.
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit

class RescheduledAppointmentDetailsViewController: UIViewController {

    @IBOutlet weak var cancelRescheduledAppointmentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        cancelRescheduledAppointmentButton.layer.cornerRadius = 5
        cancelRescheduledAppointmentButton.layer.borderWidth = 1
        cancelRescheduledAppointmentButton.layer.borderColor = UIColor.white.cgColor
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
