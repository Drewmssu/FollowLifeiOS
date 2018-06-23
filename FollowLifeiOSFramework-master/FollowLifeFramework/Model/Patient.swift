//
//  Patient.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Patient {
    public var id: Int
    public var userId: Int
    public var planId: Int
    public var createdAt: String
    public var status: String
    public var updatedAt: String
    public var age: String
    public var bloodType: String
    public var weight: Float
    public var sex: String
    public var height: Float
    
    public init() {
        self.id = 0
        self.userId = 0
        self.planId = 0
        self.createdAt = Utils.getTimeNow()
        self.status = ""
        self.updatedAt = Utils.getTimeNow()
        self.age = ""
        self.bloodType = ""
        self.weight = Float("0.0000")!
        self.sex = ""
        self.height = Float("0.0000")!
    }
    
    public init(id: Int, userId: Int,  planId: Int?, createdAt: Date, status: String, updatedAt: Date, age: String?, bloodType: String?, weight: Float?, sex: String?, height: Float?) {
        self.id = id
        self.userId = userId
        self.planId = (planId == nil) ? 0 : planId!
        self.createdAt = Utils.convertTime(from: createdAt)
        self.status = status
        self.updatedAt = Utils.convertTime(from: updatedAt)
        self.age = (age == nil) ? "" : age!
        self.bloodType = (bloodType == nil) ? "" : bloodType!
        self.weight = (weight == nil) ? Float("0.0000")! : weight!
        self.sex = (sex == nil) ? "" : sex!
        self.height = (height == nil) ? Float("0.0000")! : height!
    }
    
    public init(id: Int, userId: Int,  planId: Int?, createdAt: String, status: String, updatedAt: String, age: String?, bloodType: String?, weight: Float?, sex: String?, height: Float?) {
        self.id = id
        self.userId = userId
        self.planId = (planId == nil) ? 0 : planId!
        self.createdAt = createdAt
        self.status = status
        self.updatedAt = updatedAt
        self.age = (age == nil) ? "" : age!
        self.bloodType = (bloodType == nil) ? "" : bloodType!
        self.weight = (weight == nil) ? Float("0.0000")! : weight!
        self.sex = (sex == nil) ? "" : sex!
        self.height = (height == nil) ? Float("0.0000")! : height!
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  userId: jsonObject["userId"].intValue,
                  planId: jsonObject["planId"].intValue,
                  createdAt: jsonObject["createdAt"].stringValue,
                  status: jsonObject["status"].stringValue,
                  updatedAt: jsonObject["updatedAt"].stringValue,
                  age: jsonObject["age"].stringValue,
                  bloodType: jsonObject["bloodType"].stringValue,
                  weight: jsonObject["weight"].floatValue,
                  sex: jsonObject["sex"].stringValue,
                  height: jsonObject["height"].floatValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Patient] {
        var patients = [Patient]()
        let count = jsonArray.count
        for i in 0..<count {
            patients.append(Patient.init(from: jsonArray[i]))
        }
        return patients
    }
}
