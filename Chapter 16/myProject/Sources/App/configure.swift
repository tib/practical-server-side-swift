//
//  configure.swift
//
//
//  Created by Tibor Bodecs on 2021. 12. 25..
//

import Vapor
import Fluent
import FluentSQLiteDriver
import Liquid
import LiquidLocalDriver
@_exported import AppApi

public func configure(_ app: Application) throws {
    
    /// setup Fluent with a SQLite database under the Resources directory
    let dbPath = app.directory.resourcesDirectory + "db.sqlite"
    app.databases.use(.sqlite(.file(dbPath)), as: .sqlite)
    
    /// setup Liquid using the local file storage driver
    app.fileStorages.use(.local(publicUrl: "http://localhost:8080",
                                publicPath: app.directory.publicDirectory,
                                workDirectory: "assets"), as: .local)
    
    /// set the max file upload limit
    app.routes.defaultMaxBodySize = "10mb"
    
    /// use the Public directory to serve public files
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    /// extend paths to always contain a trailing slash
    app.middleware.use(ExtendPathMiddleware())
    
    /// setup sessions
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    
    /// setup modules
    let modules: [ModuleInterface] = [
        WebModule(),
        UserModule(),
        AdminModule(),
        ApiModule(),
        BlogModule(),
    ]
    for module in modules {
        try module.boot(app)
    }
    for module in modules {
        try module.setUp(app)
    }
    
    /// use automatic database migration
    try app.autoMigrate().wait()
}

