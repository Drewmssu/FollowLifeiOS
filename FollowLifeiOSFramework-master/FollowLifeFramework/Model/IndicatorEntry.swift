//
//  IndicatorEntry.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class IndicatorEntry {
    public var id: Int
    public var indicatorId: Int
    public var value: String
    public var createdAt: String
    
    public init() {
        self.id = 0
        self.indicatorId = 0
        self.value = ""
        self.createdAt = Utils.getTimeNow()
    }
    
    public init(id: Int, indicatorId: Int, value: String, createdAt: Date) {
        self.id = id
        self.indicatorId = indicatorId
        self.value = value
        self.createdAt = Utils.convertTime(from: createdAt)
    }
    
    public init(id: Int, indicatorId: Int, value: String, createdAt: String) {
        self.id = id
        self.indicatorId = indicatorId
        self.value = value
        self.createdAt = createdAt
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  indicatorId: jsonObject["indicatorId"].intValue,
                  value: jsonObject["value"].stringValue,
                  createdAt: jsonObject["createdAt"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [IndicatorEntry] {
        var indicatorEntries = [IndicatorEntry]()
        let count = jsonArray.count
        for i in 0..<count {
            indicatorEntries.append(IndicatorEntry.init(from: jsonArray[i]))
        }
        return indicatorEntries
    }
}
