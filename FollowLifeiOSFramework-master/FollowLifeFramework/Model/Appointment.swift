//
//  Appointment.swift
//  FollowLife
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Appointment {
    public var id: Int
    public var patientId: Int
    public var doctorId: Int
    public var createdAt: String
    public var appointmentDate: String
    public var canceledAt: String
    public var reason: String
    public var status: String
    public var updatedAt: String
    
    public init() {
        self.id = 0
        self.patientId = 0
        self.doctorId = 0
        self.createdAt = Utils.getTimeNow()
        self.appointmentDate = Utils.getTimeNow()
        self.canceledAt = Utils.getTimeNow()
        self.reason = ""
        self.status = ""
        self.updatedAt = Utils.getTimeNow()
    }
    
    public init(id: Int, patientId: Int?, doctorId: Int?, createdAt: Date, appointmentDate: Date, canceledAt: Date?, reason: String?, status: String, updatedAt: Date?) {
        self.id = id
        self.patientId = (patientId == nil) ? 0 : patientId!
        self.doctorId = (doctorId == nil) ? 0 : doctorId!
        self.createdAt = Utils.convertTime(from: createdAt)
        self.appointmentDate = Utils.convertTime(from: appointmentDate)
        self.canceledAt = Utils.convertTime(from: canceledAt)
        self.reason = (reason == nil) ? "" : reason!
        self.status = status
        self.updatedAt = Utils.convertTime(from: updatedAt)
    }
    
    public init(id: Int, patientId: Int?, doctorId: Int?, createdAt: String, appointmentDate: String, canceledAt: String?, reason: String?, status: String, updatedAt: String?) {
        self.id = id
        self.patientId = (patientId == nil) ? 0 : patientId!
        self.doctorId = (doctorId == nil) ? 0 : doctorId!
        self.createdAt = createdAt
        self.appointmentDate = appointmentDate
        self.canceledAt = (canceledAt == nil) ? Utils.getTimeNow() : canceledAt!
        self.reason = (reason == nil) ? "" : reason!
        self.status = status
        self.updatedAt = (updatedAt == nil) ? Utils.getTimeNow() : updatedAt!
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  patientId: jsonObject["patientId"].intValue,
                  doctorId: jsonObject["doctorId"].intValue,
                  createdAt: jsonObject["createdAt"].stringValue,
                  appointmentDate: jsonObject["appointmentDate"].stringValue,
                  canceledAt: jsonObject["canceledAt"].stringValue,
                  reason: jsonObject["reason"].stringValue,
                  status: jsonObject["status"].stringValue,
                  updatedAt: jsonObject["updatedAt"].stringValue)
    }
    
    public static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Appointment] {
        var appointments = [Appointment]()
        let count = jsonArray.count
        for i in 0..<count {
            appointments.append(Appointment.init(from: jsonArray[i]))
        }
        return appointments
    }
}
