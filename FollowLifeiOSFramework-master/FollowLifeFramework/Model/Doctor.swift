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
    public var userId: Int
    public var planId: Int
    public var status: String
    public var createdAt: String
    public var medicIdentification: String
    public var updatedAt: String
    public var addressId: Int
    
    public init() {
        self.id = 0
        self.userId = 0
        self.planId = 0
        self.status = ""
        self.createdAt = Utils.getTimeNow()
        self.medicIdentification = ""
        self.updatedAt = Utils.getTimeNow()
        self.addressId = 0
    }
    
    public init(id: Int, userId: Int, planId: Int, status: String, createdAt: Date, medicIdentification: String?, updatedAt: Date?, addressId: Int?) {
        self.id = id
        self.userId = userId
        self.planId = planId
        self.status = status
        self.createdAt = Utils.convertTime(from: createdAt)
        self.medicIdentification = (medicIdentification == nil) ? "" : medicIdentification!
        self.updatedAt = Utils.convertTime(from: updatedAt)
        self.addressId = (addressId == nil) ? 0 : addressId!
    }
    
    public init(id: Int, userId: Int, planId: Int, status: String, createdAt: String, medicIdentification: String?, updatedAt: String?, addressId: Int?) {
        self.id = id
        self.userId = userId
        self.planId = planId
        self.status = status
        self.createdAt = createdAt
        self.medicIdentification = (medicIdentification == nil) ? "" : medicIdentification!
        self.updatedAt = (updatedAt == nil) ? Utils.getTimeNow() : updatedAt!
        self.addressId = (addressId == nil) ? 0 : addressId!
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  userId: jsonObject["userId"].intValue,
                  planId: jsonObject["planId"].intValue,
                  status: jsonObject["status"].stringValue,
                  createdAt: jsonObject["createdAt"].stringValue,
                  medicIdentification: jsonObject["medicIdentification"].stringValue,
                  updatedAt: jsonObject["updatedAt"].stringValue,
                  addressId: jsonObject["addressId"].intValue)
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
