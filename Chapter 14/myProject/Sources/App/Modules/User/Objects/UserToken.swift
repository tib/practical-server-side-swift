//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Foundation

extension User {

    enum Token: ApiModelInterface {
        typealias Module = User
    }
}

extension User.Token {
    
    struct Detail: Codable {
        let id: UUID
        let value: String
        let user: User.Account.Detail
    }
}
