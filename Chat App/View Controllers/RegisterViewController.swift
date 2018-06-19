//
//  RegisterViewController.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/16/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    let manager = UserManager()
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var confPasswordTxtField: UITextField!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if (nameTxtField.text?.isValidName())! && (emailTxtField.text?.isValidEmail())! && (passwordTxtField.text?.isValidPassword())! && passwordTxtField.text == confPasswordTxtField.text {
            manager.register(email: emailTxtField.text!, password: passwordTxtField.text!) { error in
                print("Error")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
