//
//  Networkable.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/5/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import Foundation

protocol Networkable {
    func create<T: FirestoreCodable>(object: T, completion: @escaping (Bool) -> Void)
    func delete<T: FirestoreCodable>(object: T, completion: @escaping (Bool) -> Void)
    
    func objects<T: FirestoreCodable>(object: T.Type, parameters: (String, Any)?, completion: @escaping ([T]) -> Void)
}
