//
//  AuthViewModel.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit

class AuthViewModel {
    
    @objc dynamic var email: String?
    @objc dynamic var password: String?
    
    func login() -> Bool {
        APIManager.sharedManager.loginWithEmail(email, password)
        return true
    }

}
