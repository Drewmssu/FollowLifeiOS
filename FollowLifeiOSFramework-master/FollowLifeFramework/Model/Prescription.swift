//
//  Prescription.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Prescription {
    public var id: Int
    public var doctorId: Int
    public var patientId: Int
    public var createdAt: String
    
    public init() {
        self.id = 0
        self.doctorId = 0
        self.patientId = 0
        self.createdAt = Utils.getTimeNow()
    }
    
    public init(id: Int, doctorId: Int, patientId: Int, createdAt: Date) {
        self.id = id
        self.doctorId = doctorId
        self.patientId = patientId
        self.createdAt = Utils.convertTime(from: createdAt)
    }
    
    public init(id: Int, doctorId: Int, patientId: Int, createdAt: String) {
        self.id = id
        self.doctorId = doctorId
        self.patientId = patientId
        self.createdAt = createdAt
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  doctorId: jsonObject["doctorId"].intValue,
                  patientId: jsonObject["patientId"].intValue,
                  createdAt: jsonObject["createdAt"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Prescription] {
        var prescriptions = [Prescription]()
        let count = jsonArray.count
        for i in 0..<count {
            prescriptions.append(Prescription.init(from: jsonArray[i]))
        }
        return prescriptions
    }
}
