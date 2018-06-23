//
//  FollowLifeApi.swift
//  FollowLife
//
//  Created by Hugo Andres on 22/05/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation

public class FollowLifeApi {
    private static let baseUrl: String = "https://www.followlife.me"
    
    public static var doctorsUrl: String {
        return "\(baseUrl)/api/v1/doctors"
    }
    
    public static var patientsUrl: String {
        return "\(baseUrl)/api/v1/patients"
    }
    
    public static var repositoriesUrl: String {
        return "\(baseUrl)/api/v1/repository"
    }
    
    public static var token: String {
        return Bundle.main.object(forInfoDictionaryKey: "token") as! String
    }
}
