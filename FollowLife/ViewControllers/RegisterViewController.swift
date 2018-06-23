//
//  RegisterViewController.swift
//  FollowLife
//
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var alreadyHaveAnAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.setBottomBorder()
        lastNameTextField.setBottomBorder()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        signUpButton.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func alreadyHaveAnAccountAction(_ sender: UIButton) {
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


