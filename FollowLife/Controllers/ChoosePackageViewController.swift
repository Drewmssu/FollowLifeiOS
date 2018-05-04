//
//  ChoosePackageViewController.swift
//  FollowLife
//
//  Created by Hillari Zorrilla Delgado on 4/26/18.
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit

class ChoosePackageViewController: UIViewController {
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var proOptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
       
        gradient.frame = view.bounds
        gradient.colors = [UIColor(red:0.30, green:0.69, blue:0.76, alpha:1.0).cgColor, UIColor(red:0.42, green:0.80, blue:0.99, alpha:1.0).cgColor]
        
        self.view.layer.addSublayer(gradient)
        optionButton.layer.cornerRadius = 5
        optionButton.layer.borderWidth = 1
        optionButton.layer.borderColor = UIColor.white.cgColor

        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(gestureRecognizer:)))
        proOptionLabel.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "secondPlan") as! ChoosePackage2ViewController
        self.present(nextViewController, animated:true, completion:nil)
        
        
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

