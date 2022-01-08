//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 07..
//

import Vapor

struct ApiModule: ModuleInterface {
    
    func boot(_ app: Application) throws {
        app.middleware.use(ApiErrorMiddleware())
    }
}
