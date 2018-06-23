//
//  Utils.swift
//  FollowLifeFramework
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation

public class Utils {
    private static var dateFormatter: DateFormatter = DateFormatter()
    
    public static func convertTime(from now: Date?) -> String {
        self.dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        self.dateFormatter.timeStyle = .medium
        self.dateFormatter.dateStyle = .long
        
        return (now == nil) ? dateFormatter.string(for: Date())! : dateFormatter.string(for: now)!
    }
    
    public static func convertTime(from now: String?) -> Date {
        self.dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        self.dateFormatter.timeStyle = .medium
        self.dateFormatter.dateStyle = .long
        
        return (now == nil) ? Date() : dateFormatter.date(from: now!)!
    }
    
    public static func getTimeNow() -> String {
        self.dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        self.dateFormatter.timeStyle = .medium
        self.dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: Date())
    }
    
    public static func getTimeNow() -> Date {
        return Date()
    }
}
