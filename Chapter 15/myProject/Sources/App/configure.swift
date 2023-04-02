import Vapor
import Fluent
import FluentSQLiteDriver
import Liquid
import LiquidLocalDriver

public func configure(
    _ app: Application
) throws {

    app.fileStorages.use(
        .local(
            publicUrl: "http://localhost:8080",
            publicPath: app.directory.publicDirectory,
            workDirectory: "assets"
        ),
        as: .local
    )
    
    app.routes.defaultMaxBodySize = "10mb"
    
    let dbPath = app.directory.resourcesDirectory + "db.sqlite"
    app.databases.use(.sqlite(.file(dbPath)), as: .sqlite)
    
    app.middleware.use(
        FileMiddleware(
            publicDirectory: app.directory.publicDirectory
        )
    )

    app.middleware.use(ExtendPathMiddleware())

    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)
    
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
    
    try app.autoMigrate().wait()
}
