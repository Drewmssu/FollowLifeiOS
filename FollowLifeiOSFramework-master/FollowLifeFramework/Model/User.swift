//
//  User.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class User {
    public var id: Int
    public var email: String
    public var password: String
    public var roleId: Int
    public var firstName: String
    public var lastName: String
    public var status: String
    public var phoneNumber: String
    public var profilePicture: String
    public var sessionToken: String
    public var lastIPConnection: String
    public var createdAt: String
    public var updatedOn: String
    
    public init() {
        self.id = 0
        self.email = ""
        self.password = ""
        self.roleId = 0
        self.firstName = ""
        self.lastName = ""
        self.status = ""
        self.phoneNumber = ""
        self.profilePicture = ""
        self.sessionToken = ""
        self.lastIPConnection = ""
        self.createdAt = Utils.getTimeNow()
        self.updatedOn = Utils.getTimeNow()
    }
    
    public init(id: Int, email: String, password: String, roleId: Int, firstName: String, lastName: String, status: String, phoneNumber: String?, profilePicture: String?, sessionToken: String?, lastIPConnection: String?, createdAt: Date, updatedOn: Date?) {
        self.id = id
        self.email = email
        self.password = password
        self.roleId = roleId
        self.firstName = firstName
        self.lastName = lastName
        self.status = status
        self.phoneNumber = (phoneNumber == nil) ? "" : phoneNumber!
        self.profilePicture = (profilePicture == nil) ? "" : profilePicture!
        self.sessionToken = (sessionToken == nil) ? "" : sessionToken!
        self.lastIPConnection = (lastIPConnection == nil) ? "" : lastIPConnection!
        self.createdAt = Utils.convertTime(from: createdAt)
        self.updatedOn = Utils.convertTime(from: updatedOn)
    }
    
    public init(id: Int, email: String, password: String, roleId: Int, firstName: String, lastName: String, status: String, phoneNumber: String?, profilePicture: String?, sessionToken: String?, lastIPConnection: String?, createdAt: String, updatedOn: String?) {
        self.id = id
        self.email = email
        self.password = password
        self.roleId = roleId
        self.firstName = firstName
        self.lastName = lastName
        self.status = status
        self.phoneNumber = (phoneNumber == nil) ? "" : phoneNumber!
        self.profilePicture = (profilePicture == nil) ? "" : profilePicture!
        self.sessionToken = (sessionToken == nil) ? "" : sessionToken!
        self.lastIPConnection = (lastIPConnection == nil) ? "" : lastIPConnection!
        self.createdAt = createdAt
        self.updatedOn = (updatedOn == nil) ? Utils.getTimeNow() : updatedOn!
    }
    
    public convenience init(from jsonObject: JSON) {
            self.init(id: jsonObject["id"].intValue,
                      email: jsonObject["email"].stringValue,
                      password: jsonObject["password"].stringValue,
                      roleId: jsonObject["roleId"].intValue,
                      firstName: jsonObject["firstName"].stringValue,
                      lastName: jsonObject["lastName"].stringValue,
                      status: jsonObject["status"].stringValue,
                      phoneNumber: jsonObject["phoneNumber"].stringValue,
                      profilePicture: jsonObject["profilePicture"].stringValue,
                      sessionToken: jsonObject["sessionToken"].stringValue,
                      lastIPConnection: jsonObject["lastIPConnection"].stringValue,
                      createdAt: jsonObject["createdAt"].stringValue,
                      updatedOn: jsonObject["updatedOn"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [User] {
        var users = [User]()
        let count = jsonArray.count
        for i in 0..<count {
            users.append(User.init(from: jsonArray[i]))
        }
        return users
    }
}
