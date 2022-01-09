//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Foundation

public extension User {

    enum Token: ApiModelInterface {
        public typealias Module = User
    }
}

public extension User.Token {
    
    struct Detail: Codable {
        public let id: UUID
        public let value: String
        public let user: User.Account.Detail
        
        public init(id: UUID, value: String, user: User.Account.Detail) {
            self.id = id
            self.value = value
            self.user = user
        }
    }
}
