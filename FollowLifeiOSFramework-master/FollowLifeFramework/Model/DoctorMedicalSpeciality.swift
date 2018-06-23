//
//  DoctorMedicalSpeciality.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class DoctorMedicalSpeciality {
    public var id: Int
    public var doctorId: Int
    public var medicalSpeciality: Int
    
    public init() {
        self.id = 0
        self.doctorId = 0
        self.medicalSpeciality = 0
    }
    
    public init(id: Int, doctorId: Int, medicalSpeciality: Int) {
        self.id = id
        self.doctorId = doctorId
        self.medicalSpeciality = medicalSpeciality
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  doctorId: jsonObject["doctorId"].intValue,
                  medicalSpeciality: jsonObject["medicalSpeciality"].intValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [DoctorMedicalSpeciality] {
        var doctorMedicalSpecialities = [DoctorMedicalSpeciality]()
        let count = jsonArray.count
        for i in 0..<count {
            doctorMedicalSpecialities.append(DoctorMedicalSpeciality.init(from: jsonArray[i]))
        }
        return doctorMedicalSpecialities
    }
}
