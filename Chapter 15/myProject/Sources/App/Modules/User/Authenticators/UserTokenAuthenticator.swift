//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Vapor
import Fluent

struct UserTokenAuthenticator: AsyncBearerAuthenticator {

    func authenticate(bearer: BearerAuthorization, for req: Request) async throws {
        guard let token = try await UserTokenModel.query(on: req.db).filter(\.$value == bearer.token).first() else {
            return
        }

        guard let user = try await UserAccountModel.find(token.$user.id, on: req.db) else {
            return
        }
        req.auth.login(AuthenticatedUser(id: user.id!, email: user.email))
    }
}
