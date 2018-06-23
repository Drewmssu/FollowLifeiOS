//
//  Device.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Device {
    public var id: Int
    public var userId: Int
    public var token: String
    public var createdAt: String
    
    public init() {
        self.id = 0
        self.userId = 0
        self.token = ""
        self.createdAt = Utils.getTimeNow()
    }
    
    public init(id: Int, userId: Int, token: String, createdAt: Date) {
        self.id = id
        self.userId = userId
        self.token = token
        self.createdAt = Utils.convertTime(from: createdAt)
    }
    
    public init(id: Int, userId: Int, token: String, createdAt: String) {
        self.id = id
        self.userId = userId
        self.token = token
        self.createdAt = createdAt
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  userId: jsonObject["userId"].intValue,
                  token: jsonObject["token"].stringValue,
                  createdAt: jsonObject["createdAt"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Device] {
        var devices = [Device]()
        let count = jsonArray.count
        for i in 0..<count {
            devices.append(Device.init(from: jsonArray[i]))
        }
        return devices
    }
}
