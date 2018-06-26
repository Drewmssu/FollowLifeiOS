//
//  LoginViewController.swift
//  FollowLife
//
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FollowLifeFramework

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        signInButton.layer.cornerRadius = 5
     
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "token")
        defaults.removeObject(forKey: "idPatient")
        defaults.removeObject(forKey: "fullName")
        defaults.removeObject(forKey: "email")
        defaults.synchronize()
        
        
        guard let email = emailTextField.text, !email.isEmpty,
        let password = passwordTextField.text, !password.isEmpty else {
            let alert = UIAlertController(title: "We had a problem", message: "You must fill in all the fields.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let headers = ["Accept": "application/json"]
        let parameters = ["Email" : email, "Password": password, "DeviceToken": "String"]
        
        Alamofire.request("\(FollowLifeApi.patientsUrl)/login", method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            case .success(let value):
                let jsonObject: JSON = JSON(value)
        
                if statusCode == 200 {
                
                    Preference.saveData(key: "token", value: jsonObject["Result"]["SessionToken"].stringValue)
                    let fullName = jsonObject["Result"]["FirstName"].stringValue + " " + jsonObject["Result"]["LastName"].stringValue
                    Preference.saveData(key: "idPatient", value: jsonObject["Result"]["Id"].stringValue)
                    Preference.saveData(key: "fullName", value: fullName)
                    Preference.saveData(key: "email", value: jsonObject["Result"]["Email"].stringValue)
                    
                    print(jsonObject["Result"]["SessionToken"].stringValue)
                    
                    self.performSegue(withIdentifier: "showHomeScene", sender: self)
                } else if statusCode == 401 ||  statusCode == 404 {
                    let incorrectCredentialAlert = UIAlertController(title: "Incorrect Credentials", message: jsonObject["Message"].stringValue, preferredStyle: UIAlertControllerStyle.alert)
                    incorrectCredentialAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(incorrectCredentialAlert, animated: true, completion: nil)
                } else {
                    let problemAlert = UIAlertController(title: "We had a problem", message: "We had some technical probles. Please, try again in a few minutes.", preferredStyle: UIAlertControllerStyle.alert)
                    problemAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(problemAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showRegisterScene", sender: self)
    }
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
   
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
