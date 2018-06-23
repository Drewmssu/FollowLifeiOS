//
//  Membership.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Membership {
    public var id: Int
    public var doctorId: Int
    public var patientId: Int
    public var referenceEmail: String
    public var token: String
    public var createdAt: String
    public var expiresAt: String
    public var status: String
    
    public init() {
        self.id = 0
        self.doctorId = 0
        self.patientId = 0
        self.referenceEmail = ""
        self.token = ""
        self.createdAt = Utils.getTimeNow()
        self.expiresAt = Utils.getTimeNow()
        self.status = ""
    }
    
    public init(id: Int, doctorId: Int, patientId: Int?, referenceEmail: String, token: String, createdAt: Date, expiresAt: Date, status: String) {
        self.id = id
        self.doctorId = doctorId
        self.patientId = (patientId == nil) ? 0 : patientId!
        self.referenceEmail = referenceEmail
        self.token = token
        self.createdAt = Utils.convertTime(from: createdAt)
        self.expiresAt = Utils.convertTime(from: expiresAt)
        self.status = status
    }
    
    public init(id: Int, doctorId: Int, patientId: Int?, referenceEmail: String, token: String, createdAt: String, expiresAt: String, status: String) {
        self.id = id
        self.doctorId = doctorId
        self.patientId = (patientId == nil) ? 0 : patientId!
        self.referenceEmail = referenceEmail
        self.token = token
        self.createdAt = createdAt
        self.expiresAt = expiresAt
        self.status = status
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  doctorId: jsonObject["doctorId"].intValue,
                  patientId: jsonObject["patientId"].intValue,
                  referenceEmail: jsonObject["referenceEmail"].stringValue,
                  token: jsonObject["token"].stringValue,
                  createdAt: jsonObject["createdAt"].stringValue,
                  expiresAt: jsonObject["expiresAt"].stringValue,
                  status: jsonObject["status"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Membership] {
        var memberships = [Membership]()
        let count = jsonArray.count
        for i in 0..<count {
            memberships.append(Membership.init(from: jsonArray[i]))
        }
        return memberships
    }
}
