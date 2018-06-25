//
//  ProfileViewController.swift
//  FollowLife
//
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import FollowLifeFramework
import Foundation

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
   
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
//    @IBOutlet weak var editBloodTypeButton: UIButton!
//    @IBOutlet weak var editWeightButton: UIButton!
//    @IBOutlet weak var editAgeButton: UIButton!

    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    
    let fullName: String = Preference.retreiveData(key: "fullName")
    let email: String = Preference.retreiveData(key: "email")
    let token: String = Preference.retreiveData(key: "token")
    let idPatient: String = Preference.retreiveData(key: "idPatient")

    var bloodTypeList: [String] = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    
    var sexList: [String] = ["Femenino","Masculino"]
    
    var bloodTypePicker : UIPickerView!
    var sexTypePicker : UIPickerView!
    
    var selectedBloodType : String = String()
    var selectedSex : String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPatientInfo()
        bloodTypeTextField.isUserInteractionEnabled = false
        weightTextField.isUserInteractionEnabled = false
        ageTextField.isUserInteractionEnabled = false
        heightTextField.isUserInteractionEnabled = false
        sexTextField.isUserInteractionEnabled = false

        nameLabel!.text = fullName
        emailLabel!.text = email
        
//        weightTextField.delegate = self
//        ageTextField.delegate = self
//        heightTextField.delegate = self

        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.black.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        presentImagePickerController(forSourceType: .photoLibrary)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func presentImagePickerController(forSourceType sourceType: UIImagePickerControllerSourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = sourceType
            self.present(pickerController, animated: true, completion: nil)
        } else {
            print("Source Type Not Available")
        }
    }

    @IBAction func editBloodTypeAction(_ sender: UIButton) {
           self.bloodTypeTextField.isUserInteractionEnabled = true
        self.bloodTypePicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        createPicker(textField: self.bloodTypeTextField, picker: self.bloodTypePicker)
         self.bloodTypeTextField.becomeFirstResponder()
    }

    @IBAction func editWeightAction(_ sender: UIButton) {
       self.weightTextField.isUserInteractionEnabled = true
        self.weightTextField.keyboardType = UIKeyboardType.decimalPad
        addToolbar(textField: self.weightTextField)
        self.weightTextField.becomeFirstResponder()
    }
    
    @IBAction func logOutAction(_ sender: UIBarButtonItem) {
         //self.performSegue(withIdentifier: "unwindSegueToLogin", sender: self)
        logOut()
    }
    
    
    @IBAction func editHeightAction(_ sender: UIButton) {
        self.heightTextField.isUserInteractionEnabled = true
        self.heightTextField.keyboardType = UIKeyboardType.decimalPad
        addToolbar(textField: self.heightTextField)
        self.heightTextField.becomeFirstResponder()
    }
    
    @IBAction func editSexAction(_ sender: UIButton) {
        self.sexTextField.isUserInteractionEnabled = true
        
        self.sexTypePicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        createPicker(textField: self.sexTextField, picker: self.sexTypePicker)
        self.sexTextField.becomeFirstResponder()
    }
    
    
    @IBAction func editAgeAction(_ sender: UIButton) {
        ageTextField.isUserInteractionEnabled = true
        self.ageTextField.keyboardType = UIKeyboardType.numberPad
        addToolbar(textField: self.ageTextField)
        self.ageTextField.becomeFirstResponder()
    }
    
    func loadPatientInfo() {
        
        Alamofire.request("\(FollowLifeApi.patientsUrl)/\(self.idPatient)", method: .get, encoding: JSONEncoding.default, headers: ["X-FLLWLF-TOKEN": self.token, "Content-Type": "application/json"]).responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            case .success(let value):
                
                let jsonObject: JSON = JSON(value)
                if statusCode == 200 {
                    let bloodtype = jsonObject["Result"]["bloodType"].stringValue
                    let weight = jsonObject["Result"]["weight"].stringValue
                    let height = jsonObject["Result"]["height"].stringValue
                    let age = jsonObject["Result"]["age"].stringValue
                    let sex = jsonObject["Result"]["sex"].stringValue
                    
                    guard bloodtype == "null" else {
                        self.bloodTypeTextField.text = bloodtype
                        return
                    }
                    guard  weight == "null" else {
                        self.weightTextField.text = weight
                        return
                    }
                    guard height == "null" else {
                        self.heightTextField.text = height
                        return
                    }
                    guard age == "null" else {
                        self.ageTextField.text = age
                        return
                    }
                    guard sex == "null" else {
                        self.sexTextField.text = sex
                        return
                    }
                    //                    self.editSpecialtyButton.isEnabled = false
                    //                    self.specialtyTextField.isUserInteractionEnabled = false
                    
                }
               
                
            }
        }
    }
    
    func updatePatient(parameter: String, val: String){
        
           
           let parameters = [
                parameter: val
            ]
        
        Alamofire.request("\(FollowLifeApi.patientsUrl)/\(self.idPatient)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: ["X-FLLWLF-TOKEN": self.token, "Content-Type": "application/json"]).responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            case .success(let value):
                
                let jsonObject: JSON = JSON(value)
                print(statusCode    )
                if statusCode == 200 {
                    print(jsonObject)
                    //                    self.editSpecialtyButton.isEnabled = false
                    //                    self.specialtyTextField.isUserInteractionEnabled = false
                    
                }
                else {
                
                    self.showErrorMessage()
                }
                
            }
        }
    }
    
    func logOut(){
        
        
        Alamofire.request("\(FollowLifeApi.patientsUrl)/logout", method: .get, encoding: JSONEncoding.default, headers: ["X-FLLWLF-TOKEN": self.token, "Accept": "application/json"]).responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            case .success(let value):
                
                let jsonObject: JSON = JSON(value)
                print(statusCode)
                if statusCode == 200 {
                    
    
                }
                else {
                    
                    self.showErrorMessage()
                }
                
            }
        }
    }
    
    @objc func doneClicked() {

        if(bloodTypeTextField.isFirstResponder ==  true) {
            
            bloodTypeTextField.isUserInteractionEnabled = false
            let bloodtype = bloodTypeTextField.text
            if bloodtype != "" {
                updatePatient(parameter: "BloodType", val: bloodtype!)
            }
            bloodTypeTextField.resignFirstResponder()
        } else if(sexTextField.isFirstResponder ==  true) {
            
            sexTextField.isUserInteractionEnabled = false
            let sex = sexTextField.text
            if sex != "" {
                updatePatient(parameter: "Sex", val: sex!)
            }
            sexTextField.resignFirstResponder()
        } else if(heightTextField.isFirstResponder ==  true) {
            heightTextField.isUserInteractionEnabled = false
            let height = heightTextField.text
            if height != "" {
                updatePatient(parameter: "Height", val: height!)
            }
            heightTextField.resignFirstResponder()
        } else if(weightTextField.isFirstResponder ==  true) {
            weightTextField.isUserInteractionEnabled = false
            let weight = weightTextField.text
            if weight != "" {
                updatePatient(parameter: "Weight", val: weight!)
            }
            weightTextField.resignFirstResponder()
        } else if(ageTextField.isFirstResponder ==  true) {
            ageTextField.isUserInteractionEnabled = false
            let age = ageTextField.text
            if age != "" {
                updatePatient(parameter: "Age", val: age!)
            }
            ageTextField.resignFirstResponder()
        }
        

    }

    @objc func cancelClicked() {
      
        if(bloodTypeTextField.isFirstResponder ==  true) {
            bloodTypeTextField.text = ""
            bloodTypeTextField.isUserInteractionEnabled = false
            bloodTypeTextField.resignFirstResponder()
        } else if(sexTextField.isFirstResponder ==  true) {
            sexTextField.text = ""
            sexTextField.isUserInteractionEnabled = false
            sexTextField.resignFirstResponder()
        } else if(heightTextField.isFirstResponder ==  true) {
            heightTextField.text = ""
            heightTextField.isUserInteractionEnabled = false
            heightTextField.resignFirstResponder()
        } else if(weightTextField.isFirstResponder ==  true) {
            weightTextField.text = ""
            weightTextField.isUserInteractionEnabled = false
            weightTextField.resignFirstResponder()
        } else if(ageTextField.isFirstResponder ==  true) {
            ageTextField.text = ""
            ageTextField.isUserInteractionEnabled = false
            ageTextField.resignFirstResponder()
        }
        
    }
    
    func showErrorMessage() {
        let problemAlert = UIAlertController(title: "We had a problem", message: "We had some technical problems. Please, try again in a few minutes.", preferredStyle: UIAlertControllerStyle.alert)
        problemAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(problemAlert, animated: true, completion: nil)
    }
    
    
    func addToolbar(textField : UITextField){
       
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
    }
    
    func createPicker(textField : UITextField,picker : UIPickerView) {
        
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        textField.inputView = picker
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
//        toolbar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClicked))
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
        
        //self.specialtyPicker.addSubview(toolbar)
        
        
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Action cancelled")
        self.profileImageView.image = UIImage(named: "no-photo")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImageView.image = pickedImage
                        picker.dismiss(animated: true, completion: nil)
            
        }
        
    }
}
extension ProfileViewController: UINavigationControllerDelegate {
    

    
}

//extension ProfileViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
//}

extension ProfileViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == bloodTypePicker {
            selectedBloodType = bloodTypeList[row]
            return bloodTypeList[row]
        } else if pickerView == sexTypePicker {
            selectedSex = sexList[row]
            return sexList[row]
        }
        
        return "-1"
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == bloodTypePicker {
            self.bloodTypeTextField.text = bloodTypeList[row]
        } else if pickerView == sexTypePicker {
            self.sexTextField.text = sexList[row]
        }
        
    }
}

extension ProfileViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == bloodTypePicker {
            return bloodTypeList.count
        } else if pickerView == sexTypePicker {
            return sexList.count
        }
        return -1
    }

}


