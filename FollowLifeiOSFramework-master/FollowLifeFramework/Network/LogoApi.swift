//
//  LogoApi.swift
//  FollowLife
//
//  Created by Hugo Andres on 22/05/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation

public class LogoApi {
    private static let baseUrl = "https://logo.clearbit.com/"
    
    public static func urlToLogo(forUrl url: String) -> String {
        if let url = URL(string: url) {
            return "\(baseUrl)\(url.host!)"
        } else {
            return "\(baseUrl)\(url)"
        }
        
    }
}
