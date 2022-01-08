//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Vapor

struct ValidationError: Codable {

    let message: String?
    let details: [ValidationErrorDetail]
    
    init(message: String?, details: [ValidationErrorDetail]) {
        self.message = message
        self.details = details
    }
}

extension ValidationError: Content {}
