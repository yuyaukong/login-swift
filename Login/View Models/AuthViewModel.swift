//
//  AuthViewModel.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit

class AuthViewModel: NSObject {
    
    @objc dynamic var email: String = ""
    @objc dynamic var password: String = ""
    @objc dynamic var canLogin: Bool = false

    func login() {
        APIManager.sharedManager.loginWithEmail(email, password)
    }

    func checkLoginValidate() {
        self.canLogin = !email.isEmpty && email.isEmail() && !password.isEmpty && password.isPassword()
    }
}
