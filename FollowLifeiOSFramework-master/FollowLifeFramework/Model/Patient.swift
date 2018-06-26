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
    public var user: User
    public var weight: Float
    public var height: Float
    public var age: String
    public var bloodType: String
    public var sex: String
    
    public init() {
        self.id = 0
        self.user = User.init()
        self.age = ""
        self.bloodType = ""
        self.weight = Float("0.0000")!
        self.sex = ""
        self.height = Float("0.0000")!
    }
    
    public init(id: Int, user: User, weight: Float?, height: Float?, age: String? , bloodType: String?, sex: String?) {
        self.id = id
        self.user = user
        self.weight = (weight == nil) ? Float("0.0000")! : weight!
        self.height = (height == nil) ? Float("0.0000")! : height!
        self.age = (age == nil) ? "" : age!
        self.bloodType = (bloodType == nil) ? "" : bloodType!
        self.sex = (sex == nil) ? "" : sex!
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  user: User.init(from: jsonObject["user"]),
                  weight: jsonObject["weight"].floatValue,
                  height: jsonObject["height"].floatValue,
                  age: jsonObject["age"].stringValue,
                  bloodType: jsonObject["bloodType"].stringValue,
                  sex: jsonObject["sex"].stringValue)
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
