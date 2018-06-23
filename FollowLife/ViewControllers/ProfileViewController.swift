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

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var editBloodTypeButton: UIButton!
    @IBOutlet weak var editWeightButton: UIButton!
    @IBOutlet weak var editAgeButton: UIButton!
    
    @IBOutlet weak var bloodTypeTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    
    let fullName: String = Preference.retreiveData(key: "fullName")
    let phoneNumber: String = Preference.retreiveData(key: "phoneNumber")
    let email: String = Preference.retreiveData(key: "email")
    let token: String = Preference.retreiveData(key: "token")
    let idPatient: String = Preference.retreiveData(key: "idPatient")

    var bloodTypeList: [String] = ["A+","A-","B+","B-","O+","O-","AB+","AB-"]
    
    var bloodTypePicker : UIPickerView!
    var selectedBloodType : String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bloodTypeTextField.isUserInteractionEnabled = false
        weightTextField.isUserInteractionEnabled = false
        ageTextField.isUserInteractionEnabled = false
        
        nameLabel!.text = fullName
        phoneLabel!.text = phoneNumber
        emailLabel!.text = email
        
        weightTextField.delegate = self
        ageTextField.delegate = self

        
        Alamofire.request("\(FollowLifeApi.patientUrl)/\(idPatient)", method: .get, headers: ["X-FLLWLF-TOKEN": token, "Accept": "application/json"])
            .responseJSON { (response) in

            let statusCode = response.response?.statusCode
           
            switch response.result {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")

                case .success(let value):
                  
                    let jsonObject: JSON = JSON(value)

                    if statusCode == 200 {
                        print(jsonObject)
                        if jsonObject["Result"]["medicIdentification"].stringValue as String == "null" {
                            let problemAlert = UIAlertController(title: "No CMP code registered", message: "Register your CMD code to gain full access to the app.", preferredStyle: UIAlertControllerStyle.alert)
                            problemAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(problemAlert, animated: true, completion: nil)
                        } else {
                            self.editCmdButton.isEnabled = false
                            self.cmpTextField.text = jsonObject["Result"]["medicIdentification"].stringValue
                        }
                        
                        if (jsonObject["Result"]["medicalSpeciality"].isEmpty) {
                        } else {
                            self.editSpecialtyButton.isEnabled = false
                            self.specialtyTextField.text = jsonObject["Result"]["medicalSpeciality"][0]["Name"].stringValue
                        
                        }
                        if jsonObject["Result"]["address"].stringValue as String != "null" {
                            
                            self.editAddressButton.isEnabled = false
                         self.addressLabel.text = jsonObject["Result"]["address"]["Street"].stringValue + " " + jsonObject["Result"]["address"]["Number"].stringValue + ". " + jsonObject["Result"]["address"]["complement"].stringValue + ". " + jsonObject["Result"]["address"]["Neighborhood"].stringValue + ", " + jsonObject["Result"]["address"]["District"].stringValue
                        }

                    }
            }
        }
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
            bloodTypeTextField.isUserInteractionEnabled = true
         self.bloodTypeTextField.becomeFirstResponder()
    }

    @IBAction func editWeightAction(_ sender: UIButton) {
        weightTextField.isUserInteractionEnabled = true
        self.weightTextField.becomeFirstResponder()
    }
    
    @IBAction func editAgeAction(_ sender: UIButton) {
            ageTextField.isUserInteractionEnabled = true
            self.ageTextField.becomeFirstResponder()
    }
    
    @objc func doneClick() {
     
        bloodTypeTextField.resignFirstResponder()
        let name = bloodTypeTextField.text!
       
        let parameters = [
            "MedicalSpecialities": "specialty"
        ]
        
        Alamofire.request("\(FollowLifeApi.doctorsUrl)/\(self.idDoctor)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: ["X-FLLWLF-TOKEN": self.token, "Content-Type": "application/json"]).responseJSON { (response) in
            
            let statusCode = response.response?.statusCode
            
            switch response.result {
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            case .success(let value):
                
                let jsonObject: JSON = JSON(value)
                print(jsonObject)
                if statusCode == 200 {
                    
                    self.editSpecialtyButton.isEnabled = false
                    self.specialtyTextField.isUserInteractionEnabled = false

                }
                else {
                    print(jsonObject)
                    self.showErrorMessage()
                }
                
            }
        }
        
    }
    
    @objc func cancelClick() {
        bloodTypeTextField.resignFirstResponder()
    }
    
    func showErrorMessage() {
        let problemAlert = UIAlertController(title: "We had a problem", message: "We had some technical problems. Please, try again in a few minutes.", preferredStyle: UIAlertControllerStyle.alert)
        problemAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(problemAlert, animated: true, completion: nil)
    }
    

    
    func createPicker(_ textField : UITextField) {
        
        self.bloodTypePicker = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.bloodTypePicker.delegate = self
        self.bloodTypePicker.dataSource = self
        self.bloodTypePicker.backgroundColor = UIColor.white
        textField.inputView = self.bloodTypePicker
        
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ProfileViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ProfileViewController.cancelClick))
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

extension ProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ProfileViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         selectedBloodType = bloodTypeList[row]
        return bloodTypeList[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.bloodTypeTextField.text = bloodTypeList[row]
    }
}

extension ProfileViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bloodTypeList.count
    }

}




