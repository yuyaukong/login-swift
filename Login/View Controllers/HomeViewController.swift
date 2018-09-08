//
//  HomeViewController.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let vm = HomeViewModel()

    @IBOutlet weak var tokenLabel:UILabel!
    @IBOutlet weak var logoutButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tokenLabel.text = self.vm.accessToken
        
        self.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func logout() {
        SessionManager.sharedManager.clear()
    }
    
}
