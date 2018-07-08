//
//  StringExtension.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/14/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import Foundation

extension String {
    
    func isValidPassword() -> Bool {
        return self.count > 4
    }
    
    func isValidEmail() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        return self.count > 3
    }
    
}


extension Optional {
    
    func isSome() -> Bool {
        return self != nil
    }
}
