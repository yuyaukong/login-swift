//
//  LoginViewController.swift
//  Login
//
//  Created by andrew on 8/9/2018.
//  Copyright © 2018年 andrew. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    let vm = AuthViewModel()

    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    @IBOutlet weak var loginButton:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.passwordTextField.isSecureTextEntry = true
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.emailTextField.addTarget(self, action: #selector(emailDidChange(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(passwordDidChange(_:)), for: .editingChanged)
        self.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)

        self.vm.addObserver(self, forKeyPath: "canLogin", options: [.initial, .old], context: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath?.elementsEqual("canLogin") ?? false {
            self.loginButton.isEnabled = self.vm.canLogin
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTextField {
            self.passwordTextField.becomeFirstResponder()
        }
        
        if textField == self.passwordTextField {
            self.passwordTextField.endEditing(true)
            return false
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.passwordTextField {
            let characterSet = CharacterSet.alphanumerics
            if string.rangeOfCharacter(from: characterSet.inverted) != nil {
                return false
            }
        }
        return true
    }

    @objc func emailDidChange(_ textField: UITextField) {
        self.vm.email = textField.text ?? ""
        self.vm.checkLoginValidate()
    }
    
    @objc func passwordDidChange(_ textField: UITextField) {
        self.vm.password = textField.text ?? ""
        self.vm.checkLoginValidate()
    }
    
    @objc func login() {
        //hide keyboard
        self.emailTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        
        self.vm.login()
    }

    deinit {
        self.vm.removeObserver(self, forKeyPath: "canLogin")
    }
}
