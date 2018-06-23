//
//  Role.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Role {
    public var id: Int
    public var name: String
    public var shortName: String
    
    public init() {
        self.id = 0
        self.name = ""
        self.shortName = ""
    }
    
    public init(id: Int, name: String, shortName: String) {
        self.id = id
        self.name = name
        self.shortName = shortName
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  name: jsonObject["name"].stringValue,
                  shortName: jsonObject["shortName"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Role] {
        var roles = [Role]()
        let count = jsonArray.count
        for i in 0..<count {
            roles.append(Role.init(from: jsonArray[i]))
        }
        return roles
    }
}
