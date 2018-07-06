//
//  InitialViewController.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/12/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let manager = UserManager()
        
        if manager.current() {
            let vc = storyboard?.instantiateViewController(withIdentifier: "mainNavigation")
            present(vc!, animated: true, completion: nil)
        } else {
            let vc  = storyboard?.instantiateViewController(withIdentifier: "loginRegisterNavigation")
            present(vc!, animated: true, completion: nil)
        }
    }
    
}
