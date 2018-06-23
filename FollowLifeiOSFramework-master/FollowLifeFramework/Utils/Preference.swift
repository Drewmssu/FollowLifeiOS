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
        let value: String = preferences.string(forKey: key)!
        
        return value
    }
    
    public static func retreiveData(key: String) -> Int {
        let value: Int = preferences.integer(forKey: key)
        
        return value
    }
}
