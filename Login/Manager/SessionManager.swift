//
//  SessionManager.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit
import CoreData

class SessionManager {
    static let sharedManager = SessionManager()

    @objc dynamic var accessToken = ""
    @objc dynamic var isAuthenticated = false

    func clear() {
        // Clear all data
        self.accessToken = ""
        self.isAuthenticated = false
    }
}
