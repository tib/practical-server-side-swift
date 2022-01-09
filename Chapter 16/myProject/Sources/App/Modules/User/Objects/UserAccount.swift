//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Foundation

extension User {

    enum Account: ApiModelInterface {
        typealias Module = User
    }
}

extension User.Account {
    
    struct List: Codable {
        let id: UUID
        let email: String
    }
    
    struct Detail: Codable {
        let id: UUID
        let email: String
    }
    
    struct Create: Codable {
        let email: String
        let password: String
    }
    
    struct Update: Codable {
        let email: String
        let password: String?
    }
    
    struct Patch: Codable {
        let email: String?
        let password: String?
    }
}
