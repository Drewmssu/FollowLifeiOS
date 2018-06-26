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
    public var district: String
    public var street: String
    public var neighborhood: String
    public var complement: String
    public var number: String
    
    public init() {
        self.id = 0
        self.district = ""
        self.street = ""
        self.neighborhood = ""
        self.complement = ""
        self.number = ""
    }
    
    public init(id: Int, district: String, street: String, neighborhood: String, complement: String?, number: String) {
        self.id = id
        self.district = district
        self.street = street
        self.neighborhood = neighborhood
        self.complement = (complement == nil) ? "" : complement!
        self.number = number
    }

    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  district: jsonObject["district"].stringValue,
                  street: jsonObject["street"].stringValue,
                  neighborhood: jsonObject["neighborhood"].stringValue,
                  complement: jsonObject["complement"].stringValue,
                  number: jsonObject["number"].stringValue)
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
