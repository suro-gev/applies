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
        return self.count > 8
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
