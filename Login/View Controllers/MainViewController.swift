//
//  MainViewController.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let vm = MainViewModel()

    @IBOutlet weak var containerView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SessionManager.sharedManager.addObserver(self, forKeyPath: "accessToken", options: [.initial, .old], context: nil)
    }
        
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath?.elementsEqual("accessToken") ?? false {
            if SessionManager.sharedManager.accessToken.isEmpty {
                self.embedAuthScene()
            }else {
                self.embedHomeScene()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func embedAuthScene() {
        self.cleanUpEmbeddedViews()
        
        if let authVC = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController(){
            self.addChildViewController(authVC)
            self.containerView.addSubview(authVC.view)
        }
    }
    
    func embedHomeScene() {
        self.cleanUpEmbeddedViews()
        
        if let homeVC = UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController(){
            self.addChildViewController(homeVC)
            self.containerView.addSubview(homeVC.view)
        }
    }
    
    func cleanUpEmbeddedViews() {
        for vc in self.childViewControllers {
            vc.removeFromParentViewController()
        }
        
        for subview in self.containerView.subviews {
            subview.removeFromSuperview()
        }
    }

    deinit {
        SessionManager.sharedManager.removeObserver(self, forKeyPath: "accessToken")
    }

}
