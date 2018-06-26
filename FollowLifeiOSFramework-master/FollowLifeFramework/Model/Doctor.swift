//
//  Doctor.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Doctor {
    public var id: Int
    public var user: User
    public var medicIdentification: String
    public var address: Address
    public var medicalSpecialities: [MedicalSpeciality]
    public var numberOfPatients: Int
    
    public init() {
        self.id = 0
        self.user = User.init()
        self.medicIdentification = ""
        self.address = Address.init()
        self.medicalSpecialities = [MedicalSpeciality.init()]
        self.numberOfPatients = 0
    }
    
    public init(id: Int, user: User, medicIdentification: String, addres: Address, medicalSpecialities: [MedicalSpeciality], numberOfPatients: Int?) {
        self.id = id
        self.medicIdentification = medicIdentification
        self.user = user
        self.address = addres
        self.medicalSpecialities = medicalSpecialities
        self.numberOfPatients = (numberOfPatients == nil) ? 0 : numberOfPatients!
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  user: User.init(from: jsonObject["user"]),
                  medicIdentification: jsonObject["medicIdentification"].stringValue,
                  addres: Address.init(from: jsonObject["address"]),
                  medicalSpecialities: MedicalSpeciality.buildCollection(fromJSONArray: jsonObject["medicalSpeciality"].arrayValue),
                  numberOfPatients: jsonObject["numberOfPatients"].intValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Doctor] {
        var doctors = [Doctor]()
        let count = jsonArray.count
        for i in 0..<count {
            doctors.append(Doctor.init(from: jsonArray[i]))
        }
        return doctors
    }
}
