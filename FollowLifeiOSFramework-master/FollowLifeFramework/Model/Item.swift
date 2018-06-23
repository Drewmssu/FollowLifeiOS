//
//  Item.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Item {
    public var id: Int
    public var prescriptionId: Int
    public var itemTypeId: Int
    public var frequency: String
    public var quantity: Int
    public var durationInDays: Int
    public var description: String
    public var createdAt: String
    
    public init() {
        self.id = 0
        self.prescriptionId = 0
        self.itemTypeId = 0
        self.frequency = ""
        self.quantity = 0
        self.durationInDays = 0
        self.description = ""
        self.createdAt = Utils.getTimeNow()
    }
    
    public init(id: Int, prescriptionId: Int, itemTypeId: Int?, frequency: String?, quantity: Int?, durationInDays: Int?, description: String?, createdAt: Date) {
        self.id = id
        self.prescriptionId = prescriptionId
        self.itemTypeId = (itemTypeId == nil) ? 0 : itemTypeId!
        self.frequency = (frequency == nil) ? "" : frequency!
        self.quantity = (quantity == nil) ? 0 : quantity!
        self.durationInDays = (durationInDays == nil) ? 0 : durationInDays!
        self.description = (description == nil) ? "" : description!
        self.createdAt = Utils.convertTime(from: createdAt)
    }
    
    public init(id: Int, prescriptionId: Int, itemTypeId: Int?, frequency: String?, quantity: Int?, durationInDays: Int?, description: String?, createdAt: String) {
        self.id = id
        self.prescriptionId = prescriptionId
        self.itemTypeId = (itemTypeId == nil) ? 0 : itemTypeId!
        self.frequency = (frequency == nil) ? "" : frequency!
        self.quantity = (quantity == nil) ? 0 : quantity!
        self.durationInDays = (durationInDays == nil) ? 0 : durationInDays!
        self.description = (description == nil) ? "" : description!
        self.createdAt = createdAt
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  prescriptionId: jsonObject["prescriptionId"].intValue,
                  itemTypeId: jsonObject["itemTypeId"].intValue,
                  frequency: jsonObject["frequency"].stringValue,
                  quantity: jsonObject["quantity"].intValue,
                  durationInDays: jsonObject["durationInDays"].intValue,
                  description: jsonObject["description"].stringValue,
                  createdAt: jsonObject["createdAt"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Item] {
        var items = [Item]()
        let count = jsonArray.count
        for i in 0..<count {
            items.append(Item.init(from: jsonArray[i]))
        }
        return items
    }
}
