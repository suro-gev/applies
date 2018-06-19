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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        guard let psw  = passwordTextField.text, psw.isValidPassword() else {
            let alert = UIAlertController(title: "Warning", message: "Short password", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.passwordTextField.text = nil
            })
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        guard let email = emailTextField.text, email.isValidEmail() else {
            let alert = UIAlertController(title: "Warning", message: "Incorrect email", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                self.emailTextField.text = nil
            })
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            return
        }
        
        manager.login(email: email, password: psw) { status in
            if status {
                self.navigationController?.dismiss(animated: true, completion: nil)
            } else {
                print("error")
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}
