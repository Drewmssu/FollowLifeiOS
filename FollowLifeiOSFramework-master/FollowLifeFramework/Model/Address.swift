//
//  Address.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Address {
    public var id: Int
    public var districtId: Int
    public var street: String
    public var neighborhood: String
    public var complement: String
    public var number: String
    public var status: String
    public var createdAt: String
    public var updatedAt: String
    
    public init() {
        self.id = 0
        self.districtId = 0
        self.street = ""
        self.neighborhood = ""
        self.complement = ""
        self.number = ""
        self.status = ""
        self.createdAt = Utils.getTimeNow()
        self.updatedAt = Utils.getTimeNow()
    }
    
    public init(id: Int, districtId: Int, street: String, neighborhood: String, complement: String?, number: String, status: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.districtId = districtId
        self.street = street
        self.neighborhood = neighborhood
        self.complement = (complement == nil) ? "" : complement!
        self.number = number
        self.status = status
        self.createdAt = Utils.convertTime(from: createdAt)
        self.updatedAt = Utils.convertTime(from: updatedAt)
    }
    
    public init(id: Int, districtId: Int, street: String, neighborhood: String, complement: String?, number: String, status: String, createdAt: String, updatedAt: String) {
        self.id = id
        self.districtId = districtId
        self.street = street
        self.neighborhood = neighborhood
        self.complement = (complement == nil) ? "" : complement!
        self.number = number
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  districtId: jsonObject["districtId"].intValue,
                  street: jsonObject["street"].stringValue,
                  neighborhood: jsonObject["neighborhood"].stringValue,
                  complement: jsonObject["complement"].stringValue,
                  number: jsonObject["number"].stringValue,
                  status: jsonObject["status"].stringValue,
                  createdAt: jsonObject["createdAt"].stringValue,
                  updatedAt: jsonObject["updatedAt"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Address] {
        var addresses = [Address]()
        let count = jsonArray.count
        for i in 0..<count {
            addresses.append(Address.init(from: jsonArray[i]))
        }
        return addresses
    }
}
