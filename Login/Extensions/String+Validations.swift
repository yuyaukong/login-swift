//
//  String+Validations.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import Foundation

extension String {
    
    func isEmail() -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+")
            .evaluate(with:self)
    }
    
    func isPassword() -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z]+")
            .evaluate(with:self)
    }

}
