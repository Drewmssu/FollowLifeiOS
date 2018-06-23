//
//  ProfileViewModel.swift
//  FollowLife
//
//  Created by Hillari Zorrilla Delgado on 6/22/18.
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import Foundation
import UIKit
import FollowLifeFramework

protocol CMPViewModel {

}


class ProfileViewModel {
    let model: Doctor
    
    //    let emailFieldViewModel = EmailViewModel()
    //    let passwordFieldViewModel = PasswordViewModel()
    
    
    init(model: Doctor) {
        self.model = model
    }
    /*
     func validForm() -> Bool {
     return emailFieldViewModel.validate() && passwordFieldViewModel.validate()
     }
     */
    
}


extension CMPViewModel {
    
    func validateCmp(_ cmp: String) -> Bool {
        let isNumeric = Int(cmp)
        guard cmp != nil && cmp.count == 6 && isNumeric != nil else
        { return false }
        return true
    }
}


