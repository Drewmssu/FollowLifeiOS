//
//  Preference.swift
//  FollowLifeFramework
//
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation

public class Preference {
    private static let preferences: UserDefaults = UserDefaults.standard
    
    
    public static func saveData(key: String, value: String) {
        preferences.set(value, forKey: key)
        
        let didSave = preferences.synchronize()
        
        if !didSave {
            print("Error saving \(value) in UserDefaults")
        }
    }
    
    public static func retreiveData(key: String) -> String {
        let value: String
        
        if preferences.string(forKey: key) != nil {
            value = preferences.string(forKey: key)!
        } else {
            value = ""
        }
        
        return value
    }
    
    public static func retreiveData(key: String) -> Int {
        let value: Int
        
        if preferences.integer(forKey: key) != nil {
            value = preferences.integer(forKey: key)
        } else {
            value = 0
        }
        
        return value
    }
}
