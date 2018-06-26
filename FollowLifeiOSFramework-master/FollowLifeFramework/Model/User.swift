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
    public var sessionToken: String
    public var firstName: String
    public var lastName: String
    public var email: String
    public var profileImage: String
    public var phoneNumber: String
    
    public init() {
        self.id = 0
        self.sessionToken = ""
        self.email = ""
        self.firstName = ""
        self.lastName = ""
        self.phoneNumber = ""
        self.profileImage = ""
    }
    
    public init(id: Int, sessionToken: String?, firstName: String, lastName: String, email: String, profileImage: String?, phoneNumber: String?) {
        self.id = id
        self.sessionToken = (sessionToken == nil) ? "" : sessionToken!
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profileImage = (profileImage == nil) ? "" : profileImage!
        self.phoneNumber = (phoneNumber == nil) ? "" : phoneNumber!
    }
    
    public convenience init(from jsonObject: JSON) {
            self.init(id: jsonObject["id"].intValue,
                      sessionToken: jsonObject["sessionToken"].stringValue,
                      firstName: jsonObject["firstName"].stringValue,
                      lastName: jsonObject["lastName"].stringValue,
                      email: jsonObject["email"].stringValue,
                      profileImage: jsonObject["profileImage"].stringValue,
                      phoneNumber: jsonObject["phoneNumber"].stringValue)
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
