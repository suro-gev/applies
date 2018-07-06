//
//  File.swift
//  Chat App
//
//  Created by Suren Gevorkyan on 7/6/18.
//  Copyright © 2018 Suren Gevorkyan. All rights reserved.
//

import UIKit

public typealias CompletionValue<T> = (_ response: T?) -> Void
public typealias CompletionValues<T> = (_ response: [T]) -> Void
public typealias CompletionBlock = (_ response: Bool) -> Void
