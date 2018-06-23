//
//  Indicator.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Indicator {
    public var id: Int
    public var patientId: Int
    public var unitOfMeasurementId: Int
    public var quantity: Float
    public var createdAt: String
    public var indicatorTypeId: Int
    public var frequency: String
    
    public init() {
        self.id = 0
        self.patientId = 0
        self.unitOfMeasurementId = 0
        self.quantity = Float("0.0000")!
        self.createdAt = Utils.getTimeNow()
        self.indicatorTypeId = 0
        self.frequency = ""
    }
    
    public init(id: Int, patientId: Int, unitOfMeasurementId: Int, quantity: Float, createdAt: Date, indicatorTypeId: Int, frequency: String) {
        self.id = id
        self.patientId = patientId
        self.unitOfMeasurementId = unitOfMeasurementId
        self.quantity = quantity
        self.createdAt = Utils.convertTime(from: createdAt)
        self.indicatorTypeId = indicatorTypeId
        self.frequency = frequency
    }
    
    public init(id: Int, patientId: Int, unitOfMeasurementId: Int, quantity: Float, createdAt: String, indicatorTypeId: Int, frequency: String) {
        self.id = id
        self.patientId = patientId
        self.unitOfMeasurementId = unitOfMeasurementId
        self.quantity = quantity
        self.createdAt = createdAt
        self.indicatorTypeId = indicatorTypeId
        self.frequency = frequency
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init( id: jsonObject["id"].intValue,
                  patientId: jsonObject["patientId"].intValue,
                  unitOfMeasurementId: jsonObject["unitOfMeasurementId"].intValue,
                  quantity: jsonObject["quantity"].floatValue,
                  createdAt: jsonObject["createdAt"].stringValue,
                  indicatorTypeId: jsonObject["indicatorTypeId"].intValue,
                  frequency: jsonObject["frequency"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Indicator] {
        var indicators = [Indicator]()
        let count = jsonArray.count
        for i in 0..<count {
            indicators.append(Indicator.init(from: jsonArray[i]))
        }
        return indicators
    }
}
