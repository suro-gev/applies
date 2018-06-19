//
//  UserManager.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/12/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import Foundation
import FirebaseAuth


class UserManager {
    
    func currentUser() -> Bool {
        if Auth.auth().currentUser.isSome() {
            return true
        }
        return false
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
    
}
