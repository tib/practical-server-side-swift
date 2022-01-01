//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

struct UserLoginContext {

    let icon: String
    let title: String
    let message: String
    let email: String?
    let password: String?
    let error: String?
    
    init(icon: String,
         title: String,
         message: String,
         email: String? = nil,
         password: String? = nil,
         error: String? = nil) {
        self.icon = icon
        self.title = title
        self.message = message
        self.email = email
        self.password = password
        self.error = error
    }
}

