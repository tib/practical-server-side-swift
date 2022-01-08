//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 31..
//

import Vapor

struct WebModule: ModuleInterface {

    let router = WebRouter()

    func boot(_ app: Application) throws {
        try router.boot(routes: app.routes)
    }
    
    func setUp(_ app: Application) throws {
        try router.setUpRoutesHooks(app: app)
    }
}
