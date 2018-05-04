//
//  PrescriptionTypeViewController.swift
//  FollowLife
//
//  Created by Hillari Zorrilla Delgado on 5/2/18.
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit

class PrescriptionTypeViewController: UIViewController {

    @IBOutlet weak var chooseMedicineButton: UIButton!
    @IBOutlet weak var chooseExerciseButton: UIButton!
    @IBOutlet weak var chooseFoodButton: UIButton!
    @IBOutlet weak var chooseOtherTreatment: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseMedicineButton.layer.cornerRadius = 5
        chooseMedicineButton.layer.borderWidth = 1
        chooseMedicineButton.layer.borderColor = UIColor.lightGray.cgColor
        
        chooseExerciseButton.layer.cornerRadius = 5
        chooseExerciseButton.layer.borderWidth = 1
        chooseExerciseButton.layer.borderColor = UIColor.lightGray.cgColor
        
        chooseFoodButton.layer.cornerRadius = 5
            chooseFoodButton.layer.borderWidth = 1
            chooseFoodButton.layer.borderColor = UIColor.lightGray.cgColor
        
        chooseOtherTreatment.layer.cornerRadius = 5
        chooseOtherTreatment.layer.borderWidth = 1
        chooseOtherTreatment.layer.borderColor = UIColor.lightGray.cgColor
        
        
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
