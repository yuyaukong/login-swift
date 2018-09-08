//
//  SessionManager.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit
import CoreData

class SessionManager: NSObject {
    static let sharedManager = SessionManager()

    @objc dynamic var accessToken = ""
    @objc dynamic var isAuthenticated = false
    
    override init() {
        super.init()
        
        self.addObserver(self, forKeyPath: "accessToken", options: [.initial, .old], context: nil)
    }
    
    func clear() {
        // Clear all data
        self.accessToken = ""
        self.isAuthenticated = false
    }
    
    deinit {
        
    }
}
