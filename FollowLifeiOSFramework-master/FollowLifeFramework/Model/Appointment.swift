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
    public var appointmentDate: String
    public var reason: String
    public var patient: Patient
    public var status: String
    
    public init() {
        self.id = 0
        self.appointmentDate = Utils.getTimeNow()
        self.reason = ""
        self.patient = Patient.init()
        self.status = ""
    }
    
    public init(id: Int, appointmentDate: Date, reason: String?, patient: Patient?, status: String) {
        self.id = id
        self.appointmentDate = Utils.convertTime(from: appointmentDate)
        self.reason = (reason == nil) ? "" : reason!
        self.patient = (patient == nil) ? Patient.init() : patient!
        self.status = status
    }
    
    public init(id: Int, appointmentDate: String, reason: String?, patient: Patient?, status: String) {
        self.id = id
        self.appointmentDate = appointmentDate
        self.reason = (reason == nil) ? "" : reason!
        self.patient = (patient == nil) ? Patient.init() : patient!
        self.status = status
    }
    
    public convenience init(from jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  appointmentDate: jsonObject["appointmentDate"].stringValue,
                  reason: jsonObject["reason"].stringValue,
                  patient: Patient.init(from: jsonObject["patient"]),
                  status: jsonObject["status"].stringValue)
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
