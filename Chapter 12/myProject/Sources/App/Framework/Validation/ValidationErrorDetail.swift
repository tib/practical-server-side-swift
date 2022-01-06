//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor

public struct ValidationErrorDetail: Codable {

    public var key: String
    public var message: String
    
    public init(key: String, message: String) {
        self.key = key
        self.message = message
    }
}

extension ValidationErrorDetail: Content {}
