//
//  UserManager.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/12/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class UserManager: Networkable {
    
    
    func current() -> Bool {
        if Auth.auth().currentUser.isSome() {
            return true
        }
        return false
    }
    
    func currentID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        Auth.auth().signInAndRetrieveData(with: credential) { (result, _) in
            guard let id = result?.user.uid else {
                completion(false)
                return
            }
            self.objects(object: User.self, parameters: ("email", email), completion: { (users) in
                for user in users {
                    if user.id == id {
                        completion(true)
                        return
                    }
                }
                completion(false)
                return
            })
        }
    }
    
    func register(user: User, completion: @escaping (Bool) -> Void) {
        guard let email = user.email, let password = user.password else {
            completion(false)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let id = result?.user.uid else {
                completion(false); return }            
            user.id = id
            self.create(object: user, completion: { (status) in
                completion(status)
            })
        }
    }
    
    
    func allUsers(completion: @escaping ([User]) -> Void) {
        guard let id = Auth.auth().currentUser?.uid else {
            completion([User]())
            return
        }
        
        objects(object: User.self, parameters: nil) { (users) in
            let filteredUsers = users.filter({ (user) -> Bool in
                if user.id == id {
                    return false
                }
                return true
            })
            completion(filteredUsers)
        }
    }

    func logout() {
        try? Auth.auth().signOut()
    }
    
}



enum Response {
    case noInternet
    case failed(String)
    case success
}
