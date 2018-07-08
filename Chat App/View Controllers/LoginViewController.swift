//
//  LoginViewController.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/12/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let manager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        guard let psw  = passwordTextField.text, psw.isValidPassword() else {
            createAlert(with: "Warning", and: "Invalid Password")
            return
        }
                guard let email = emailTextField.text, email.isValidEmail() else {
            createAlert(with: "Wrning", and: "Invalid Email")
            return
        }
        
        
        ThemeService().showLoading(true)
        manager.login(email: email, password: psw) { status in
            ThemeService().showLoading(false)
            if status {
                self.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                self.createAlert(with: "Login error", and: "Account not found. Please enter your login and password again.")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    private func createAlert(with title: String, and text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "Done", style: .default, handler: { _ in
            self.passwordTextField.text = ""
            self.emailTextField.text = ""
            self.emailTextField.becomeFirstResponder()
            
        })
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

}
