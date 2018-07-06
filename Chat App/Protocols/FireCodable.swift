//
//  FireCodable.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 6/20/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

protocol FirestoreCodable: class {
    var id: String {get set}
    static func reference() -> String
    func mappedData() -> [String: Any]
    init?(_ values: [String: Any]?)
}

protocol FirestorageCodable: FirestoreCodable {
    var profilePic: UIImage? {get set}
    var profilePicLink: String? {get set}
    
}
