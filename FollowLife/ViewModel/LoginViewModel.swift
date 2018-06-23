//
//  LoginViewModel.swift
//  FollowLife
//
//  Created by Hillari Zorrilla Delgado on 4/22/18.
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit

protocol EmailViewModel {
    var title: String { get }
    var errorMessage: String { get }
}

// Options for FieldViewModel
protocol PasswordViewModel {
    var isSecureTextEntry: Bool { get }
}


class LoginViewModel {
    let model: LoginModel
    
//    let emailFieldViewModel = EmailViewModel()
//    let passwordFieldViewModel = PasswordViewModel()
    
    
    init(model: LoginModel) {
        self.model = model
    }
    
/*
    func validForm() -> Bool {
        return emailFieldViewModel.validate() && passwordFieldViewModel.validate()
    }
*/
    
}


extension EmailViewModel {
    func validateEmail(_ email: String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
}
extension PasswordViewModel {
    func validatePassword(_ pass: String?) -> Bool {
        guard pass != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: pass)
    }
  
}
