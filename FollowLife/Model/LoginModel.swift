//
//  LoginModel.swift
//  FollowLife
//
//  Created by Hillari Zorrilla Delgado on 4/22/18.
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import Foundation
class LoginModel {
    var email: String = ""
    var password: String = ""
    convenience init(email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}
