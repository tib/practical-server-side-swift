//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Foundation

public extension User {

    enum Account: ApiModelInterface {
        public typealias Module = User
    }
}

public extension User.Account {
    
    struct Login: Codable {
        public let email: String
        public let password: String
        
        public init(email: String, password: String) {
            self.email = email
            self.password = password
        }
    }
    
    struct List: Codable {
        public let id: UUID
        public let email: String
        
        public init(id: UUID, email: String) {
            self.id = id
            self.email = email
        }
    }
    
    struct Detail: Codable {
        public let id: UUID
        public let email: String
        
        public init(id: UUID, email: String) {
            self.id = id
            self.email = email
        }
    }
    
    struct Create: Codable {
        public let email: String
        public let password: String
        
        public init(email: String, password: String) {
            self.email = email
            self.password = password
        }
    }
    
    struct Update: Codable {
        public let email: String
        public let password: String?
        
        public init(email: String, password: String) {
            self.email = email
            self.password = password
        }
    }
    
    struct Patch: Codable {
        public let email: String?
        public let password: String?
        
        public init(email: String?, password: String?) {
            self.email = email
            self.password = password
        }
    }
}
