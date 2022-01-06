//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2022. 01. 02..
//

import Vapor

struct AdminModule: ModuleInterface {

    let router = AdminRouter()

    func boot(_ app: Application) throws {
        try router.boot(routes: app.routes)
    }
}
