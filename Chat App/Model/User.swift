//
//  User.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/12/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

class User: FirestorageCodable {
    
    var id: String = UUID().uuidString
    var name: String?
    var lastName: String?
    var email: String?
    var password: String?
    var profilePicLink: String?
    var profilePic: UIImage?
    
    class func reference() -> String {
        return "Users"
    }
    
    func mappedData() -> [String : Any] {
        var data = [String: Any]()
        data["id"] = id
        data["name"] = name
        data["lastName"] = lastName
        data["email"] = email
        data["profilePicLink"] = profilePicLink
        return data
    }
    
    init() {}
    
    required convenience init?(_ values: [String : Any]?) {
        guard let data = values, let id = data["id"] as? String else { return nil }
        self.init()
        self.id = id
        name = data["name"] as? String
        lastName = data["lastName"] as? String
        email = data["email"] as? String
        profilePicLink = data["profilePicLink"] as? String
    }
    
    
}
