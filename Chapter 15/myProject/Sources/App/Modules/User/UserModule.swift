//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

import Vapor
import SwiftHtml

struct UserModule: ModuleInterface {

    let router = UserRouter()

    func boot(_ app: Application) throws {
        app.migrations.add(UserMigrations.v1())
        app.migrations.add(UserMigrations.seed())
        
        app.middleware.use(UserSessionAuthenticator())
        app.middleware.use(UserTokenAuthenticator())
        
        try router.boot(routes: app.routes)
    }
}

