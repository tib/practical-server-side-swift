//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Vapor

struct ApiModule: ModuleInterface {
    
    let router = ApiRouter()
    
    func boot(_ app: Application) throws {
        app.middleware.use(ApiErrorMiddleware())
        
        try router.boot(routes: app.routes)
    }
    
    func setUp(_ app: Application) throws {
        try router.setUpRoutesHooks(app: app)
    }
}
