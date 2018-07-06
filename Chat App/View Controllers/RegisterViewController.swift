//
//  RegisterViewController.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/16/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let picker = ImagePickerService()
    let manager = UserManager()
    let user = User()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!

    
    
    @IBAction func registerAction(_ sender: Any) {
        if passwordTextField.text == confirmPasswordTextField.text {
            user.name = nameTextField.text
            user.lastName = lastNameTextField.text
            user.email = emailTextField.text
            user.password = passwordTextField.text
            ThemeService().showLoading(true)
            UserManager().register(user: user) {[weak self] status in
                if status {
                    self?.navigationController?.dismiss(animated: true, completion: nil)
                } else {
                    print("error")
                }
                ThemeService().showLoading(false)
            }
        } else {
            passwordTextField.text = nil
            confirmPasswordTextField.text = nil
            let alert = UIAlertController(title: "Passwords don't match!", message: "Please enter your password again!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
        
    }
    
    @IBAction func selectImage(_ sender: Any) {
        picker.pick(from: self) {[weak self] image in
            self?.profileImageView.image = image
            self?.user.profilePic = image
        }
    }
    
    
}
