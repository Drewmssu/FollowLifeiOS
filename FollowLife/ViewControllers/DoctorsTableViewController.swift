//
//  DoctorsTableViewController.swift
//  FollowLife
//
//  Created by Hillari Zorrilla Delgado on 6/26/18.
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import FollowLifeFramework

class DoctorsTableViewCell: UITableViewCell {
    
    var id: Int = 0
    @IBOutlet weak var nameLabel: UILabel!
    
    
    public func setValues(fromPatient doctor: User) {
        self.id = doctor.id
        self.nameLabel.text = "\(doctor.firstName) \(doctor.lastName)"
    }
    
    public func setValues(fromName doctorName: String) {
        nameLabel.text = doctorName
    }
}

class DoctorsTableViewController: UITableViewController {

    
    let token: String = Preference.retreiveData(key: "token")
    let idPatient: String = Preference.retreiveData(key: "idPatient")
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.updateViews()
    }

    @IBAction func addAction(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a room",
                                      message: "Submit your doctor's code.",
                                      preferredStyle: .alert)
        
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: { (action) -> Void in
            let textField = alert.textFields![0]
            let code = textField.text!
        
            let parameters = [
                "Code": code
            ]
                
                
            Alamofire.request("\(FollowLifeApi.patientsUrl)/\(self.idPatient)/membership", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: ["X-FLLWLF-TOKEN": self.token, "Content-Type": "application/json"]).responseJSON { (response) in
                    
                    let statusCode = response.response?.statusCode
                    
                    switch response.result {
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                        
                    case .success(let value):
                        
                        let jsonObject: JSON = JSON(value)
                        
                        if statusCode == 200 {
                            self.showSuccessMessage()
                        }
                        else {
                            self.showErrorMessage()
                        }
                        
                    }
                }
      
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
        
        alert.addTextField {
            (textField: UITextField) in
            textField.keyboardAppearance = .dark
            textField.keyboardType = .default
            textField.autocorrectionType = .default
            textField.clearButtonMode = .whileEditing
        }
        alert.addAction(submitAction)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    
    }
    
    func showErrorMessage() {
        let problemAlert = UIAlertController(title: "We had a problem", message: "We had some technical problems. Please, try again in a few minutes.", preferredStyle: UIAlertControllerStyle.alert)
        problemAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(problemAlert, animated: true, completion: nil)
    }
    
    func showSuccessMessage() {
        let problemAlert = UIAlertController(title: "New room added", message: "You connected with a new doctor.", preferredStyle: UIAlertControllerStyle.alert)
        problemAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(problemAlert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell", for: indexPath) as! DoctorsTableViewCell

        let user = self.users[indexPath.row]
        
        cell.setValues(fromPatient: user)

        return cell
    }
    
    func updateViews() {
        let headers = [
            "X-FLLWLF-TOKEN": self.token,
            "Accept": "application/json"
        ]
        Alamofire.request("\(FollowLifeApi.patientsUrl)/\(self.idPatient)/doctors", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { (response) in
                let statusCode = response.response?.statusCode
                
                switch response.result {
                case .failure( _):
                    self.showErrorMessage()
                    
                case .success(let value):
                    let jsonObject = JSON(value)["Result"].arrayValue
                    
                    if statusCode == 200 {
                        for i in 0..<jsonObject.count {
                            self.users.append(User.init(id: jsonObject[i]["id"].intValue,
                                                        sessionToken: nil,
                                                        firstName: jsonObject[i]["name"].stringValue,
                                                        lastName: "",
                                                        email: "",
                                                        profileImage: nil,
                                                        phoneNumber: nil))
                            
                            self.tableView?.reloadData()
                        }
                    }
                }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
