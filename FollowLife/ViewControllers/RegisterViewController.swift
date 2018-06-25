//
//  RegisterViewController.swift
//  FollowLife
//
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FollowLifeFramework

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
        
        self.firstNameTextField.delegate = self as! UITextFieldDelegate
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        guard let firstname = firstNameTextField.text, firstname != "", let lastname = lastNameTextField.text, lastname != "", let email = emailTextField.text, email != "", let password = passwordTextField.text, password != "" else {
            showErrorMessage()
            return
        }
        
        let headers = ["Accept": "application/json"]
        let parameters = ["FirstName": firstname, "LastName": lastname, "Email" : email, "Password": password]
        
        Alamofire.request("\(FollowLifeApi.patientsUrl)/register", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            case .success(let value):
                let jsonObject: JSON = JSON(value)
                
                
                if statusCode == 200 {
                        print(jsonObject)
                    
                } else {
                    let problemAlert = UIAlertController(title: "We had a problem", message: "We had some technical probles. Please, try again in a few minutes.", preferredStyle: UIAlertControllerStyle.alert)
                    problemAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(problemAlert, animated: true, completion: nil)
                }
            }
        }
        
        
    }
    @IBAction func alreadyHaveAnAccountAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func showErrorMessage() {
        let problemAlert = UIAlertController(title: "We had a problem", message: "Complete all the fields to proceed .", preferredStyle: UIAlertControllerStyle.alert)
        problemAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(problemAlert, animated: true, completion: nil)
    }

}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

